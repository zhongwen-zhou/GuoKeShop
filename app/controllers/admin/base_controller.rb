module Admin
	class BaseController < ::ActionController::Base
		layout 'admin'
	  protect_from_forgery with: :exception
	  helper_method :current_user
		before_filter :authorize_login

	  def current_user
	  	User.where(:id => session[:user_id]).first if session[:user_id]
	  end

		def authorize_login
			redirect_to new_admin_session_path unless current_user
		end
	end
end