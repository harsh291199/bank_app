class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to transaction_history_path, notice: 'Logged in successfully.'
    else
      redirect_to new_session_path, alert: 'Invalid email or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path, notice: 'Logged out successfully.'
  end
end
