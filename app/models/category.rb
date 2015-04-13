# 商品类别
class Category
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String	#类别名称
end
