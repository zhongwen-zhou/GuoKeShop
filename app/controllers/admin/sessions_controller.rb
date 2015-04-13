module Admin
class SessionsController < BaseController
	skip_filter :authorize_login, :except => [:destroy]
    protect_from_forgery with: :exception, :only => [:destroy]

	def create
		user = User.authorize_user(params[:account], params[:password])		

		if user
			session[:user_id] = user.id.to_s
			redirect_to admin_root_path
		else
			flash[:notice] = '账号或密码错误！'
			render :new
		end
	end

	def new
		@game = Game.new
	end

	def destroy
		session[:user_id] = nil
		redirect_to admin_root_path
	end
end
end
