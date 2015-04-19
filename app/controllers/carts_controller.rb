class CartsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: ['add_to_cart']
	def index
		render json: session[:cut]
		# render json: {'32faf' => {count: 3, price: 3.00
	end

	def current_carts
		# render json: {'32faf' => {count: 3, price: 3.00}}
		# render json: {
		@items = [{id: '123', count: 3, price: 3.00}, {id: '234', count: 4, price: 4}]
	end

	def add_to_cart
		logger.info('!!!!')
		logger.info(params['item_id'])
		render json: true
	end

	def add_cut
		item = Item.find params[:id]
		session[:cut].push({item_id: params[:id], price: item.price, count: 1})
		redirect_to root_path
	end

	def clear_cut
		session[:cut] = []
		redirect_to root_path
	end

	def new
		@item = Item.new
	end

	def create
		item = Item.new(params.require(:item).permit(:name, :brand, :units, :desc, :price, :repo_count, :on_way_count, :category_id))
		item.save!

		redirect_to admin_items_path, notice: '创建成功！'
	end

	def destroy
		@item = Item.find params[:id]
		@item.destroy
		
		redirect_to admin_items_path, notice: '删除成功！'
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
