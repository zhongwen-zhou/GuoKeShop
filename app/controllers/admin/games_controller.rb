module Admin
class GamesController < BaseController
	def index
		@games = Game.all
	end

	def new
		@game = Game.new
	end

	def create
		game = Game.new(params.require(:game).permit(:name, :adId, :sale_at))
		game.creator = current_user
		game.save!

		redirect_to admin_games_path, notice: '创建成功！'
	end

	def destroy
		@game = Game.find params[:id]
		@game.destroy
		
		redirect_to admin_games_path, notice: '删除成功！'
	end

	def query
		@games = Game.all
	end

	def channel_detail
		@game = Game.find params[:id]
		@channel_games = ChannelGame.where(game: @game)
	end

	def query_channel_detail
		@game = Game.find params[:id]
		@channel_games = ChannelGame.where(game: @game)
	end
end
end