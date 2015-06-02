class ItemsController < ApplicationController
	def category
		@current_category = Category.find params[:category_id]
		if @current_category.level == 1
			@items = Item.where(top_category_id: @current_category.parent_id).order(order_index: :asc).paginate(:page => params[:page], :per_page => 20)
		else
			@items = Item.where(category_id: @current_category).order(order_index: :asc).paginate(:page => params[:page], :per_page => 20)
		end
	end

	def search
		@items = Item.where(name: /#{params[:keyword]}/).order(order_index: :asc).all.paginate(:page => params[:page])
	end

	def index
		@items = Item.where(category_id: params[:category_id]).order(order_index: :asc)
		render 'welcome/index'
	end

	def show
		@item = Item.find params[:id]
		render '/shared/frontend/_item_fast_view', layout: false
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
