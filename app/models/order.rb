# 订单
class Order
	include Mongoid::Document
	include Mongoid::Timestamps

	STATUS_NEW = 1	# 新建
	STATUS_PICKUP = 2	# 捡货中
	STATUS_ON_WAY = 3	# 送货中
	STATUS_DONE = 4	# 完成确认

	field :no, type: String	#订单编号
	field :name, type: String	#收货人称呼
	field :address, type: String	#送货地点
	field :telphone, type: String	#送货电话
	field :remark, type: String	#送货电话
	field :status, type: Integer, default: 1	#订单状态（新建订单／送货订单／完结订单）
	field :items_total_price, type: Float	#商品总价
	field :shipping_price, type: Float	#派送费
	field :total_price, type: Float	#价格
	field :items, type: Array	#商品

	field :sent_at, type: DateTime	#送货时间
	field :done_at, type: DateTime	#回执时间
end
