class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	# before_filter :authorize_login
  # helper_method :current_channel

  # def current_channel
  	# Channel.where(id: session[:channel_id]).first if session[:channel_id]
  # end

	# def authorize_login
		# redirect_to new_session_path unless current_channel
	# end
end
