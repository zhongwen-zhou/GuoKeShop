class ChannelsController < ApplicationController

  protect_from_forgery with: :exception

	def edit_password
	end

	def update_password
		_params = params.permit(:current_password, :new_password, :confirm_password)
		if Digest::MD5.hexdigest(_params[:current_password]) != current_channel.password
			return render text: '原密码不正确!'
		else
			current_channel.set(:password => Digest::MD5.hexdigest(params[:new_password]))

			if current_channel.save!
				redirect_to root_path
			else
				return render text: '未知错误！'
			end
		end
	end

end
