module Api
	class ChannelGamesController < BaseController
		def index
			@games = current_channel.channel_games
		end
	end
end