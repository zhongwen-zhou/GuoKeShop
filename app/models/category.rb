# 商品类别
class Category
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String	#类别名称
	field :level, type: Integer, default: 1	#类别层级
	field :shelf_no, type: String	#货架号

	belongs_to :parent, class_name: 'Category' #上级类别
	has_many :children, class_name: 'Category', foreign_key: :parent #下级节点

	scope :top_category, -> {where level: 1}

	validates :name, :level, presence: true

	# node_path, 0 ,001 002,001001 001002 001003
	# query
	# update path
	# read/write
end
