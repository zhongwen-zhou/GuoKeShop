module ApplicationHelper
	def is_in_cart?(item)
	  @carts = session[:carts] || {}
	  @carts.keys.include?(item.id.to_s)
	end
end
