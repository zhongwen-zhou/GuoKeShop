# 渠道
class Channel
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String
	field :account, type: String
	field :password, type: String
	field :access_token, type: String

	has_many :channel_games

	belongs_to :creator, class_name: 'User'

	def encrypt_password(_password)
		_password ||= self.password
		self.password = Digest::MD5.hexdigest(_password)
	end

	def self.authorize_channel(account, password)
		channel = Channel.where(account: account).first
		return nil unless channel
		return channel if channel.password == (Digest::MD5.hexdigest password)
	end
end