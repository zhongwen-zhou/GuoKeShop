module Admin
class WelcomeController < BaseController


	def index
		@users = User.all
		@games = Game.all
	end

	def new
		@game = Game.new
	end

	def create
		game = Game.new(params.require(:game).permit(:name, :adId))
		game.sale_at = Date.current
		game.save!
	end
end
end