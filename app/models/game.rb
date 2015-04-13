class Game
	include Mongoid::Document
	include Mongoid::Timestamps

	PLAT_IOS = 0
	PLAT_ANDROID = 1

	field :name, type: String
	field :sale_at, type: Date
	field :adId, type: String

	# 平台
	field :platform, type: Integer, default: PLAT_ANDROID

	belongs_to :creator, :class_name => 'User'

	has_many :channel_games

	def platform_name
		platform == PLAT_ANDROID ? '安卓' : 'IOS'
	end

	def id_name
		id.to_s
	end

	def add_data type
		case type
		when 'clicks_count'
			inc(clicks_count: 1)
		when 'downloads_count'
			inc(downloads_count: 1)
		when 'activate_count'
			inc(activate_count: 1)
		when 'regeisters_count'
			inc(regeisters_count: 1)
		when 'live_count'
			inc(live_count: 1)
		end

	end

	def operate_count(operation_type, channel, start_date, end_date)
		if channel == 'all'
			unless (start_date || end_date)
				AccessDetail.where(game_id: self.id.to_s, operation: operation_type).count
			else
				AccessDetail.where(game_id: self.id.to_s, operation: operation_type, :created_at.gt => start_date, :created_at.lt => end_date).count
			end			
		else
			channel_game = ChannelGame.where(channel: channel, game: self).first



			# _count = case operation_type
			# when ::AccessDetail::TYPE_ACTIVATE
			# 	channel_game.pre_active_count
			# when ::AccessDetail::TYPE_REGEISTER
			# 	channel_game.pre_registration_count
			# when ::AccessDetail::TYPE_CLICK
			# 	channel_game.pre_click_count
			# when ::AccessDetail::TYPE_DOWNLOAD
			# 	channel_game.pre_download_count
			# when ::AccessDetail::TYPE_LIVE
			# 	channel_game.pre_live_count
			# when ::AccessDetail::TYPE_LOGIN
			# 	channel_game.pre_login_count
			# else
			# 	0
			# end

			unless (start_date || end_date)
				AccessDetail.where(game_id: self.id.to_s, channel_id: channel.id.to_s, operation: operation_type).count# + _count
			else
				AccessDetail.where(game_id: self.id.to_s, channel_id: channel.id.to_s, operation: operation_type, :created_at.gt => start_date, :created_at.lt => end_date).count# + _count
			end
		end
	end

	def payment_amount(channel, start_date, end_date)
		if channel == 'all'
			unless (start_date || end_date)
				Payment.where(game_id: self.id.to_s).sum(:amount)
			else
				Payment.where(game_id: self.id.to_s, :created_at.gt => start_date, :created_at.lt => end_date).sum(:amount)
			end			
		else
			unless (start_date || end_date)
				Payment.where(game_id: self.id.to_s, channel_id: channel.id.to_s).sum(:amount)
			else
				Payment.where(game_id: self.id.to_s, channel_id: channel.id.to_s, :created_at.gt => start_date, :created_at.lt => end_date).sum(:amount)
			end
		end
	end

	def live_count(channel)
		t = Time.now
		start_date = t.at_beginning_of_week
		end_date = t.at_end_of_week
		if channel == 'all'
			AccessDetail.where(game_id: self.id.to_s, operation: AccessDetail::TYPE_THIRD_LOGIN, :created_at.gt => start_date, :created_at.lt => end_date).count
		else
			AccessDetail.where(game_id: self.id.to_s, channel_id: channel.id.to_s, operation: AccessDetail::TYPE_THIRD_LOGIN, :created_at.gt => start_date, :created_at.lt => end_date).count
		end
	end

end
