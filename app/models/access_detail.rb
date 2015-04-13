# 访问细节
class AccessDetail
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
	
	field :operation, type: Integer, default: 0
	field :telphone_no, type: String
	field :platform, type: String

	field :channel_id, type: String
	field :game_id, type: String

	belongs_to :channel_game

end