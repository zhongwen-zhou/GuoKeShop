class ChannelGame
	include Mongoid::Document
	include Mongoid::Timestamps

	belongs_to :game
	belongs_to :channel

	has_many :access_details
	has_many :payments
	has_many :data_details
end