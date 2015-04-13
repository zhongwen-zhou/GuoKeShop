module Admin
class ChannelsController < BaseController
	def index
		@channels = Channel.all
	end

	def new
		@channel = Channel.new
	end

	def create
		@channel = Channel.new(params.require(:channel).permit(:name, :account, :password))
		@channel.creator = current_user
		@channel.encrypt_password params[:channel][:password]
		if @channel.save!
			redirect_to admin_channels_path, notice: '创建渠道用户成功！'
		else
			render :new
		end
	end
end
end