# 商品类别
class Category
	include Mongoid::Document
	include Mongoid::Timestamps

	field :name, type: String	#类别名称
	field :level, type: Integer	#类别层级

	belongs_to :parent, class_name: 'Category' #上级类别
	has_many :children, class_name: 'Category', foreign_key: :parent #下级节点

	# scope :top_category,->{where level: 1}
end
