module Api
	class PaymentsController < BaseController

		def create
			payment = Payment.new
			channel_game = ChannelGame.find params[:channel_game_id]
			payment.telphone_no = params[:telphone_no]
			payment.platform = params[:platform]
			payment.channel_game = channel_game
			payment.channel_id = channel_game.channel_id
			payment.game_id = channel_game.game_id
			payment.amount = params[:amount]

			if payment.save!
				return render :json => {:msg => 'ok'}
			else
				return render :json => {:msg => 'error...'}, :status => 500
			end
		end

	end
end