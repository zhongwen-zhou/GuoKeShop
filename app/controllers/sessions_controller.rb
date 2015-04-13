class SessionsController < ApplicationController
	skip_filter :authorize_login, :except => [:destroy]
    protect_from_forgery with: :exception, :only => [:destroy]

	def create
		channel = Channel.authorize_channel(params[:account], params[:password])		

		if channel
			session[:channel_id] = channel.id.to_s
			redirect_to root_path
		else
			flash[:notice] = '账号或密码错误！'
			render :new
		end
	end

	def new
		@game = Game.new
	end

	def destroy
		session[:channel_id] = nil
		redirect_to root_path
	end
end
