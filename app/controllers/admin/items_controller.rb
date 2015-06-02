module Admin
	class ItemsController < BaseController

		before_action do
			@current_tab = 'items'
		end

		def index
			@items = Item.where(category_id: params[:category_id]).order(order_index: :asc)
		end

		def new
			@item = Item.new
		end

		def edit
			@item = Item.find(params[:id])
		end

		def create
			item = Item.new(params.require(:item).permit(:name, :brand, :units, :desc, :price, :repo_count, :on_way_count, :category_id, :on_sale, :hot, :new_arrivals))
			item.order_index = Category.find(item.category_id).children.count + 1
			item.save!

			redirect_to admin_items_path, notice: '创建成功！'
		end

		def update
			item = Item.find(params[:id])
			item.update_attributes!(params.require(:item).permit(:name, :brand, :units, :desc, :price, :repo_count, :on_way_count, :category_id, :in_price, :on_sale, :hot, :new_arrivals))
			# item.save!

			redirect_to admin_items_path, notice: '编辑成功！'
		end

		def destroy
			@item = Item.find params[:id]
			@item.destroy
			
			redirect_to admin_items_path, notice: '删除成功！'
		end

		def query
			@items = Item.all.order(order_index: :asc)
		end

		def move_up
			@item = Item.find params[:id]

			target_item = Item.where(category_id: @item.category_id, order_index: @item.order_index - 1).first

			@item.inc(order_index: -1)
			target_item.inc(order_index: 1) if target_item
			redirect_to admin_items_path(category_id: params[:category_id]), notice: '操作成功！'
		end

		def move_down
			@item = Item.find params[:id]

			target_item = Item.where(category_id: @item.category_id, order_index: @item.order_index + 1).first

			@item.inc(order_index: 1)
			target_item.inc(order_index: -1) if target_item
			redirect_to admin_items_path(category_id: params[:category_id]), notice: '操作成功！'
		end

	end
end