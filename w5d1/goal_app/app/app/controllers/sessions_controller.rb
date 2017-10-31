class SessionsController < ApplicationController

  def new
  end

  def create
    p params
    @user = User.find_by_credentials(
              params[:user][:username],
              params[:user][:password])

    if @user
      log_in!(@user)
      redirect_to goals_url
    else
      flash[:errors] = ["Invalid username/password"]
      render :new
    end
  end

  def destroy
    log_out!
    redirect_to new_session_url
  end
end
