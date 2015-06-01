module Admin
class CategoriesController < BaseController
	before_action do
		@current_tab = 'categories'
	end
	def index
		@top_categories = Category.top_category
		@current_top_category = Category.top_category.where(id: params[:category_id]).first || @top_categories.first
		@categories = @current_top_category.children
	end

	def new
		@category = Category.new
	end

	def edit
		@category = Category.find params[:id]
	end

	def create
		category = Category.new(params.require(:category).permit(:name, :parent_id, :shelf_no))
		category.level = 2 unless params[:category][:parent_id].blank?
		category.save!

		redirect_to admin_categories_path, notice: '创建成功！'
	end

	def update
		category = Category.find params[:id]
		category.update(params.require(:category).permit(:name, :parent_id, :shelf_no))
		category.level = 2 unless params[:category][:parent_id].blank?
		category.save!

		redirect_to admin_categories_path, notice: '修改成功！'
	end

	def destroy
		@category = Category.find params[:id]
		@category.destroy
		
		redirect_to admin_categories_path, notice: '删除成功！'
	end

	def query
		@games = Game.all
	end

	def channel_detail
		@game = Game.find params[:id]
		@channel_games = ChannelGame.where(game: @game)
	end

	def query_channel_detail
		@game = Game.find params[:id]
		@channel_games = ChannelGame.where(game: @game)
	end
end
end