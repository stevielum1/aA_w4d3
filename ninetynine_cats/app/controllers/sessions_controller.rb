class SessionsController < ApplicationController
  before_action :already_signed_in?, except: [:destroy]
  
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:user_name], 
      params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      redirect_to new_session_url
    end
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end
  
end
