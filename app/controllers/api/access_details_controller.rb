module Api
	class AccessDetailsController < BaseController

		def create
			access_detail = AccessDetail.new
			game = Game.find params[:channel_game_id]
			# channel_game = ChannelGame.find params[:channel_game_id]
			channel_game = ChannelGame.where(game: game, channel_id: params[:channel_id]).first
			access_detail.telphone_no = params[:telphone_no]
			access_detail.platform = params[:platform]
			access_detail.telphone_no = params[:telphone_no]
			access_detail.channel_game = channel_game
			access_detail.channel_id = channel_game.channel_id
			access_detail.game_id = channel_game.game_id
			access_detail.operation = case params[:operation]
			when 'ACTIVATE'
				AccessDetail::TYPE_ACTIVATE
			when 'REGEISTER'
				AccessDetail::TYPE_REGEISTER
			when 'CLICK'
				AccessDetail::TYPE_CLICK
			when 'DOWNLOAD'
				AccessDetail::TYPE_DOWNLOAD
			when 'LOGIN'
				AccessDetail::TYPE_LOGIN
			end

			# 验证重复注册
			if access_detail.operation == AccessDetail::TYPE_REGEISTER
				return :json => {:msg => '你已注册！'}, :status => 501 if AccessDetail.where(game_id: access_detail.game_id, operation: AccessDetail::TYPE_REGEISTER, phone_no: access_detail.telphone_no).count != 0
			end

			_access_detail = nil

			# 次登录及三登录及活跃数
			if access_detail.operation == AccessDetail::TYPE_LOGIN
				_count = AccessDetail.where(game_id: access_detail.game_id, operation: AccessDetail::TYPE_REGEISTER, phone_no: access_detail.telphone_no).count
				if _count > 0
					_access_detail = AccessDetail.new
					_channel_game = ChannelGame.find params[:channel_game_id]
					_access_detail.telphone_no = params[:telphone_no]
					_access_detail.platform = params[:platform]
					_access_detail.telphone_no = params[:telphone_no]
					_access_detail.channel_game = _channel_game
					_access_detail.channel_id = _channel_game.channel_id
					_access_detail.game_id = _channel_game.game_id					
					if _count == 1
						_access_detail.operation = AccessDetail::TYPE_SECOND_LOGIN
					elsif _count == 2
						_access_detail.operation = AccessDetail::TYPE_THIRD_LOGIN
					end
				end
			end

			if access_detail.save!
				game = Game.find access_detail.game_id
				_access_detail.save! if _access_detail
				return render :json => {:msg => 'ok'}
			else
				return render :json => {:msg => 'error...'}, :status => 500
			end
		end

	end
end