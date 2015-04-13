module Admin
	class UsersController < BaseController
		def index
			@users = User.all
		end

		def new
			@game = Game.new
		end

		def create
			game = Game.new(params.require(:game).permit(:name, :adId))
			game.sale_at = Date.current
			game.save!
		end

		def edit_password
		end

		def update_password
			if Digest::MD5.hexdigest(params[:current_password]) != current_user.password
				return render text: '原密码不正确!'
			else
				current_user.set(:password => Digest::MD5.hexdigest(params[:new_password]))

				if current_user.save!
					redirect_to admin_root_path
				else
					return render text: '未知错误！'
				end
			end
		end
	end
end