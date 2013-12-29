class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user, :logged_in? # helper_method makes these helpers available in view templates not just in controler layer

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id] # ||= means that if variable exists, then don't run code to right
  end

  def logged_in?
    !!current_user # !! turns variable into a boolean value
  end

  def require_user
    if !logged_in?
      flash[:error] = "Must be logged in to do that."
      redirect_to root_path
    end
  end
end
