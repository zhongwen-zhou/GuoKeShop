class ChannelGamesController < ApplicationController
	def index
		@games = current_channel.channel_games
	end

	def new
		@channel_game = ChannelGame.new
	end

	def create
		channel_game = ChannelGame.new(params.require(:channel_game).permit(:game_id))
		channel_game.channel = current_channel
		if channel_game.save!
			redirect_to channel_channel_games_path(current_channel), notice: '创建成功！'
		else
			render :new
		end
	end

	def query
		@games = current_channel.channel_games
	end
end
