class UsersController < ApplicationController
  before_action :already_signed_in?
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      flash[:errors] = [@user.errors.full_messages]
      redirect_to new_user_url
    end
  end
  
  private
  def user_params
    params.require(:user).permit(:user_name, :password, :session_token)
  end
end
