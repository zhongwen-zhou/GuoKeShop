module Api
	class BaseController < ::ActionController::Base
	  protect_from_forgery with: :null_session
	  helper_method :current_channel
		# before_filter :authorize_login

	  def current_channel
	  	Channel.where(id: params[:channel_id]).first if params[:channel_id]
	  end

		def authorize_login
			return render :json => {msg: '请登录!'} unless current_channel
		end
	end
end