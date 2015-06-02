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
	field :desc, type: String	#详情描述
	field :desc_html, type: String	#html版详情描述
	field :top_category_id, type: String	#顶级栏目id

	field :hot, type: Boolean, default: false	#是否热销
	field :new_arrivals, type: Boolean, default: false	#是否新品
	field :on_sale, type: Boolean, default: false	#是否促销
	field :top_category_id, type: String	#顶级栏目id

	field :on_shelf, type: Boolean, default: true	#是否上架

	# field :cover_path, type: String	#封面图片路径

	field :order_index, type: Integer, default: 1	#排序

	# field :cover, type: String	#图片

	attr_accessor :cover, :cover_cache

	belongs_to :category #分类

	scope :new_arrivals, -> {where(new_arrivals: true)}	#新品	
	scope :hot, -> {where(hot: true)}	#热品	
	scope :on_sale, -> {where(on_sale: true)}	#促销品

	scope :stockout, -> {where(repo_count: 0)}	#无货商品

	scope :on_shelf, -> {where(on_shelf: true)}	#上架商品

  # mount_uploader :cover, ::CoverUploader # 封面

	def cover_path
		"items/#{bar_code}/1.jpg"
	end


  def empty_repos?
  	repo_count == 0
  end

end
