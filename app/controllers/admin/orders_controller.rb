module Admin
class OrdersController < BaseController
	def index
		@wait_send_orders = Order.where(status: 2)
		@wait_accept_orders = Order.where(status: 3)
		@done_orders = Order.where(status: 4)
	end

	def sent
		order = Order.find params[:id]
		order.set(status: 3)
		redirect_to admin_orders_path, notice: '发货成功！'
	end

	def sent
		order = Order.find params[:id]
		order.set(status: 4)
		redirect_to admin_orders_path, notice: '发货成功！'
	end

	def new
		@order = Order.new
	end

	def create
		order = Order.new(params.require(:order).permit(:name, :brand, :units, :desc, :price, :repo_count, :on_way_count, :category_id))
		order.save!

		redirect_to admin_orders_path, notice: '创建成功！'
	end

	def destroy
		@order = Order.find params[:id]
		@order.destroy
		
		redirect_to admin_orders_path, notice: '删除成功！'
	end

	def query
		@orders = Order.all
	end

	def channel_detail
		@order = Order.find params[:id]
		@channel_orders = ChannelOrder.where(order: @order)
	end

	def query_channel_detail
		@order = Order.find params[:id]
		@channel_orders = ChannelOrder.where(order: @order)
	end
end
end