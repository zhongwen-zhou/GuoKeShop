class OrdersController < ApplicationController
	skip_before_action :verify_authenticity_token, only: ['create', 'remove_from_cart']

	def checkout_view
	  @carts = session[:carts] || {}
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


	def create

	  @carts = session[:carts] || {}
	  total_price = 0
	  items_total_price = 0
	  shipping_price = 0
	  items = []
	  unless @carts.keys.empty?
		  @carts.keys.each do |key|
		  	item = @carts[key]
		  	item_price = item['price'].to_f * item['count'].to_i
		  	items.push({item_id: key, name: item['name'], price: item['price'], item_price: item_price, count: item['count'], units: item['units']})
		  	items_total_price += item_price
		  end
		end
		shipping_price = 5 if [23,0,1,2,3,4,5,6,7].include? Time.now.hour
		# shipping_price = 2 if items_total_price < 30
		total_price = shipping_price + items_total_price


		order = Order.new#(params.require(:category).permit(:name, :parent_id, :shelf_no))

		order.no = Time.now.to_i
		order.items = []
		order.address = params[:address]
		order.telphone = params[:telphone]
		order.name = params[:name]
		order.remark = params[:remark]

		order.items_total_price = items_total_price
		order.shipping_price = shipping_price
		order.total_price = total_price





		order.items = items
		order.status = 1
		order.save!

		session[:carts] = {}

		redirect_to root_path, notice: 'order created!'
	end

end
