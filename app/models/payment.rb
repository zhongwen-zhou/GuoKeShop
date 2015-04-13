# 充值
class Payment
	include Mongoid::Document
	include Mongoid::Timestamps

	
	field :amount, type: Float, default: 0
	field :telphone_no, type: String
	field :platform, type: String

	field :channel_id, type: String
	field :game_id, type: String

	belongs_to :channel_game

end