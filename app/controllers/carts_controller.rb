class CartsController < ApplicationController
	skip_before_action :verify_authenticity_token, only: ['add_to_cart', 'remove_from_cart']

	def index
	  @carts = session[:carts]# || {}
	  @total_price = 0
	  @item_total_price = 0
	  @shipping_price = 0
	  @items = []
	  unless @carts.keys.empty?
		  @carts.keys.each do |key|
		  	item = @carts[key]
		  	item_price = item['price'].to_f * item['count'].to_i
		  	@items.push({id: key, name: item['name'], price: item['price'], item_price: item_price, count: item['count']})
		  	@item_total_price += item_price
		  end
		end
		# @shipping_price = 2 if @item_total_price < 30
		@shipping_price = 5 if [23,0,1,2,3,4,5,6,7].include? Time.now.hour
		@total_price = @shipping_price + @item_total_price
	end

	def current_carts
	  @carts = session[:carts] || {}
	  @total_price = 0
	  unless @carts.keys.empty?
		  @carts.keys.each do |key|
		  	item = @carts[key]
		  	item_price = item['price'].to_f * item['count'].to_i
		  	@total_price += item_price
		  end
		end


		render '/shared/frontend/_shopping_cart_container', layout: false
	end

	def add_to_cart
		item = Item.find params['item_id']
		return render status: 403, json: {status: 'no_item_count'} if item.empty_repos?
		session[:carts] ||= {}
		session[:carts].merge!({item.id.to_s => {name: item.name, count: params[:count], price: item.price, units: item.units}})
		render json: true
	end

	def remove_from_cart
		session[:carts].delete params['item_id']
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
