class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  include SessionsHelper
  
  before_filter :set_zone_from_session

  private
    def set_zone_from_session
    # set TZ only if stored in session. If not set then the default from config is to be used
    # (it should be set to UTC)
    Time.zone = cookies["browser.timezone"]
    end  


    # Confirms a logged-in user
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in"
        redirect_to login_url
      end
    end
end
