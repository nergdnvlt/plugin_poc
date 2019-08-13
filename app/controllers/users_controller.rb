class UsersController < ApplicationController
  def show
    if session[:user_id]
      @user = User.find_by(fs_id: session[:user_id])
    else
      reset_session
      redirect_to root_path
    end
  end
end
