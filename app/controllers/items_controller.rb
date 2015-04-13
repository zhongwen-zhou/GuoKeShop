class ItemsController < ApplicationController

	def add_cut
		session[:cut].push({item_id: params[:id], count: params[:count], price: params[:price]})
		# render 'welcome/index'
		redirect_to root_path
	end

	def clear_cut
		session[:cut] = []
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
