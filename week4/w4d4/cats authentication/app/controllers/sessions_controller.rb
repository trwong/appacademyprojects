class SessionsController < ApplicationController
   before_action :require_logged_out, except: :destroy
  def new
    render :new
  end

  def create
    login!
  end

  def destroy
    current_user.reset_session_token! if (current_user)
    session[:session_token] = nil
    redirect_to cats_url

  end

end
