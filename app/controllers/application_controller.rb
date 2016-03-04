class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # main controller all other controllers inherit from this controller
  protect_from_forgery with: :exception

  

  protected 

  def restricted_access
    if !current_user
      flash[:alert] = "You must log in"
      redirect_to new_session_path
    end
  end

  #redirects and flashes can only be used in controllers. 
  def is_admin?
    if !current_user || !current_user.admin
      flash[:alert] = "You must be an admin"
      redirect_to movies_path
    end
  end


  def current_user
    @current_user ||= User.find(session[:id]) if session[:id]
  end

  helper_method :current_user
  #helper_methods make methods avaliable to views.

end
