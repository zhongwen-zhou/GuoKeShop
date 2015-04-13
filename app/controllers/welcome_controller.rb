class WelcomeController < ApplicationController
	
	def index
		session[:cut] ||= []
		@items = Item.where(category_id: params[:category_id])
	end
end
