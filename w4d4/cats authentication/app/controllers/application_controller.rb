class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception
  helper_method :current_user

  def current_user
    return nil if session[:session_token].nil?
    @current_user||=User.find_by(session_token: session[:session_token])
  end

  def login!
    user= User.find_by_credentials( params[:user][:username], params[:user][:password])
    if (user)
      # user.reset_session_token!
      p session[:session_token]=user.session_token
      redirect_to cats_url
    else
      flash.now[:errors]=[("incorrect username or password")]
      render :new
    end
  end

  def logged_in?
    if User.find_by(session_token: session[:session_token])
    true
    else
      false
    end
  end

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to cats_url
    end
  end

  def require_logged_out
    if logged_in?
      flash[:error] = "You must not logged in to access this section"
      redirect_to cats_url
    end
  end

  def cat_is_owned_by_user?
    if (current_user.cats.find(params[:id]))
      true
    else
      redirect_to cats_url
    end
  end
end
