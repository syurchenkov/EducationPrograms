class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

  private

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def admin_user
      redirect_to(current_user) unless current_user.admin?
    end
end
