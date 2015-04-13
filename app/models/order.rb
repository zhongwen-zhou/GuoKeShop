# 订单
class Order
	include Mongoid::Document
	include Mongoid::Timestamps

	STATUS_NEW = 1	# 新建
	STATUS_ON_WAY = 2	# 送货中
	STATUS_ON_SURE = 3	# 收款确认
	STATUS_DONE = 4	# 收款确认

	field :no, type: String	#订单编号
	field :address, type: String	#送货地点
	field :telphone, type: String	#送货电话
	field :status, type: Integer, default: 1	#订单状态（新建订单／送货订单／完结订单）
	field :price, type: Float	#价格
	field :items, type: Array	#商品
end
