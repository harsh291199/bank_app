class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if user.save 
      render json: { message: "user has been created successfully", success: true, account_number: user.bank_account.id, token: user.unique_token}, status: :created 
    else
      render json: { message: user.errors.full_messages * ' ', success: false }, status: :unprocessable_entity 
    end
  end

  def login
    user = User.find_by(email: user_params[:email])&.authenticate(user_params[:password])
    if user 
      render json: { message: "Logged in successfully", token: user.unique_token, account_number: user.bank_account.id, success: true}, status: :ok
    else
      render json: { message: "User not found", success: false }, status: :not_found
    end
  end

  private
  
  def user_params
    params.require(:user).permit(:email, :password)
  end
end