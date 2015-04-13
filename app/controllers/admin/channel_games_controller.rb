module Admin
class ChannelGamesController < BaseController
	def index
		@current_channel = Channel.find params[:channel_id]
		@games = @current_channel.channel_games
	end

	def new
		@channel = Channel.find params[:channel_id]
		exist_games = ChannelGame.where(channel: @channel).map &:game_id
		@games = Game.not_in(:id => exist_games)
		@channel_game = ChannelGame.new
	end

	def create
		channel = Channel.find params[:channel_id]
		channel_game = ChannelGame.new(params.require(:channel_game).permit(:game_id))
		channel_game.channel = channel
		if channel_game.save!
			redirect_to admin_channel_channel_games_path(channel), notice: '创建成功！'
		else
			render :new
		end
	end

	def query
		@games = current_channel.channel_games
	end

	def destroy
		channel_game = ChannelGame.find params[:id]
		channel_game.destroy

		redirect_to admin_channel_channel_games_path(params[:channel_id]), notice: '删除成功！'
	end

	def edit_config
		@channel_game = ChannelGame.find params[:id]
	end

	def update_config
		@channel_game = ChannelGame.find params[:id]

		data_detail = DataDetail.where(game_id: @channel_game.game_id, channel_game: @channel_game, send_date: params[:send_date]).first

		data_detail.destroy if data_detail

		data_detail = DataDetail.new(game_id: @channel_game.game_id, channel_id: @channel_game.channel_id, channel_game: @channel_game)

		data_detail.pre_login_count = params[:login]
		data_detail.pre_active_count = params[:active]
		data_detail.pre_click_count = params[:click]
		data_detail.pre_download_count = params[:download]
		data_detail.pre_registration_count = params[:registration]
		data_detail.pre_live_count = params[:live]
		data_detail.send_date = params[:send_date]
		data_detail.pre_payment_count = params[:payment]

		data_detail.save!
		return redirect_to admin_channel_channel_games_path(params[:channel_id]), notice: '操作成功！'
	end
end
end