# 商品
class Item
	include Mongoid::Document
	include Mongoid::Timestamps

	field :bar_code, type: String	#条码
	field :name, type: String	#商品名
	field :brand, type: String	#品牌名
	field :units, type: String	#计量单位
	field :produced_at, type: Date	#生产日期
	field :expiration_at, type: Date	#保质期
	field :saled_count, type: Integer	#近期销量
	field :desc, type: String	#商品描述
	field :price, type: String	#商品定价
	field :in_price, type: String	#商品进价
	field :repo_count, type: Integer	#仓库存量
	field :shelf_no, type: String	#货架号
	field :desc, type: Integer	#详情描述
	field :desc_html, type: Integer	#html版详情描述

	attr_accessor :cover, :cover_cache

	belongs_to :category #分类

  mount_uploader :cover, ::CoverUploader # 封面

end
