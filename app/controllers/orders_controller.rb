class OrdersController < ApplicationController

	def add_cut
		session[:cut].push({item_id: params[:item_id], count: params[:count], price: params[:price]})
		# render 'welcome/index'
		redirect_to root_path
	end
	def index
		@items = Item.where(category_id: params[:category_id])
		render 'welcome/index'
	end

	def new
		@item = Item.new
	end

	def create
		order = Order.new
		# (params.require(:item).permit(:name, :brand, :units, :desc, :price, :repo_count, :on_way_count, :category_id))
		order.no = Time.now.to_i
		order.address = params[:address]
		order.telphone = params[:telphone]
		order.items = []
		order.status = 2
		order.price = params[:total_price]
		session[:cut].each do |item|
			order.items.push({item_id: params[:id], count: params[:count], price: params[:price]})
		end
		order.save!

		session[:cut] = []
		redirect_to root_path, notice: '您已下单成功！'
	end

	def destroy
		@item = Item.find params[:id]
		@item.destroy
		
		redirect_to root_path, notice: '您已下单成功！'
	end

	def query
		@items = Item.all
	end

	def channel_detail
		@item = Item.find params[:id]
		@channel_items = ChannelItem.where(item: @item)
	end

	def query_channel_detail
		@item = Item.find params[:id]
		@channel_items = ChannelItem.where(item: @item)
	end
end
