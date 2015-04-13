class User
	include Mongoid::Document
	include Mongoid::Timestamps

	# 超级管理员
	TYPE_SUPER = 0

	# 渠道
	TYPE_CHANNEL = 1

	field :name, type: String
	field :account, type: String
	field :password, type: String
	field :category, type: Integer, default: TYPE_CHANNEL

	has_many :games

	def encrypt_password(_password)
		_password ||= self.password
		self.password = Digest::MD5.hexdigest(_password)
	end

	def self.authorize_user(account, password)
		user = User.where(account: account).first
		p Digest::MD5.hexdigest password
		return nil unless user
		return user if user.password == (Digest::MD5.hexdigest password)
		# return (Digest::MD5.hexdigest password) == user.password if user
	end
end