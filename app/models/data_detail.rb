# 统计细节
class DataDetail
	include Mongoid::Document
	include Mongoid::Timestamps

	# 激活
	TYPE_ACTIVATE = 1

	# 注册
	TYPE_REGEISTER = 2

	# 点击
	TYPE_CLICK = 3

	# 下载
	TYPE_DOWNLOAD = 4

	# 登录
	TYPE_LOGIN = 5

	# 次登录
	TYPE_SECOND_LOGIN = 6

	# 三登录
	TYPE_THIRD_LOGIN = 7

	# 活跃
	TYPE_LIVE = 8
	

	field :channel_id, type: String
	field :game_id, type: String

	belongs_to :channel_game


	field :send_date, type: Date

	field :pre_login_count, type: Integer, default: 0
	field :pre_active_count, type: Integer, default: 0
	field :pre_click_count, type: Integer, default: 0
	field :pre_download_count, type: Integer, default: 0
	field :pre_registration_count, type: Integer, default: 0
	field :pre_live_count, type: Integer, default: 0

	field :pre_payment_count, type: Float, default: 0


end