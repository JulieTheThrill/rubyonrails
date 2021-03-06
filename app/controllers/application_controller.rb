class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def authenticate_user
    if session[:user_id]
       # set current user object to @current_user object variable
      @current_user = User.where({id: session[:user_id] })
      return true
    else
      redirect_to(:controller => 'sessions', :action => 'login')
      return false
    end
  end

  def save_login_state
    if session[:user_id]
      redirect_to root_url
      return false
    else
      return true
    end
  end

  def admin_required
    if user_is_admin
      return true
    else
      redirect_to root_url
      flash[:error] = "Access Denied"
      return false
    end
  end

  def login_required
    if current_user.nil?
      redirect_to controller: "sessions", action: "login"
      flash[:error] = "Please login!"
      return false
    end
    return true
  end

  private

  def current_user
    @current_user ||= User.find_by({id: session[:user_id]}) if session[:user_id]
  end
  helper_method :current_user

  def user_is_admin
    return false if current_user.nil?
    return current_user.role == "prof"
  end
  helper_method :user_is_admin

end
