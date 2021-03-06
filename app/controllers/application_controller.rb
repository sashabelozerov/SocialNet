# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = exception.message
    redirect_to users_url
  end

   filter_parameter_logging :password, :password_confirmation
   helper_method :current_user_session, :current_user

    private
      def current_user_session
        return @current_user_session if defined?(@current_user_session)
        @current_user_session = UserSession.find
      end

      def current_user
        return @current_user if defined?(@current_user)
        @current_user = current_user_session && current_user_session.user
      end

	def require_no_user
      	if current_user
        	flash[:notice] = "You must be logged out to access this page"
          redirect_to users_url
        	return false
    		end
    end

	def require_user
        unless current_user
        	flash[:notice] = "You must be logged in to access this page"
          redirect_to login_url
          return false
        end
      end
end
