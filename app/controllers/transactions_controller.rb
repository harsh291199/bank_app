class TransactionsController < ApplicationController
  def index
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      @transactions = @current_user&.transactions
    else
      redirect_to new_session_path
    end
  end
end
