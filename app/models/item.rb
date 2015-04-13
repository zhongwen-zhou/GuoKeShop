# 商品
class Item
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String	#商品名
	field :brand, type: String	#品牌名
	field :units, type: String	#计量单位
	field :desc, type: String	#商品描述
	field :price, type: String	#商品定价
	field :in_price, type: String	#商品进价
	field :repo_count, type: Integer	#仓库存量
	field :on_way_count, type: Integer	#派送量（在路上的量）

	belongs_to :category
end
