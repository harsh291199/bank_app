class Api::V1::BankAccountsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authenticate_user
  before_action :set_bank_account
  before_action :amount_to_f

  def deposit
    begin
      ActiveRecord::Base.transaction do
        @bank_account.update(balance: @bank_account.balance + @amount)
        @bank_account.transactions.create!(transaction_type: 'Deposit', amount: @amount, bank_balance: @bank_account.balance)
      end
      render json: { message: "Deposited Rs.#{@amount} successfully", account_number: @current_user.bank_account.id, current_balance: @bank_account.balance.to_f, success: true}, status: :ok
    rescue StandardError => e
      render json: { error: "Transaction has been failed: #{e.message}", success: false }, status: :internal_server_error
    end
  end

  def withdraw
    render json: { message: "insufficient balance.", success: false }, status: :unprocessable_entity unless @bank_account.balance >= @amount 
    begin
      ActiveRecord::Base.transaction do
        @bank_account.update(balance: @bank_account.balance - @amount)
        @bank_account.transactions.create!(transaction_type: 'Withdrawal', amount: @amount, bank_balance: @bank_account.balance)
      end
      render json: { message: "Withdrawn Rs.#{@amount} successfully.", account_number: @current_user.bank_account.id, current_balance: @bank_account.balance.to_f, success: true}, status: :ok
    rescue StandardError => e
      render json: { error: "Transaction has been failed: #{e.message}", success: false }, status: :internal_server_error
    end
  end

  private

  def amount_to_f
    @amount = bank_account_params[:amount].to_f
    if @amount.zero? || @amount.negative?
      render json: {message: "Please enter a valid amount", success: false }, status: :unprocessable_entity
    end
  end

  def set_bank_account
    if params[:id].to_i.equal?(@current_user.bank_account.id)
      @bank_account = @current_user.bank_account
    else
      render json: { message: "You cant access other's bank account", success: false }, status: :unauthorized
    end
  end

  def authenticate_user
    token = request.headers['Authorization']&.split(' ')&.last
    render json: { error: 'Unauthorized' }, status: :unauthorized unless token
    @current_user = User.find_by(unique_token: token)
  end

  def bank_account_params
    params.require(:bank_account).permit(:amount)
  end
end
