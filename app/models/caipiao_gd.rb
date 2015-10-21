# 广东11选5彩票模型
class CaipiaoGd
	include Mongoid::Document

	field :city_no, type: Integer, default: 0
	field :no, type: String, default: ""
	field :r_1, type: String, default: ""
	field :r_2, type: String, default: ""
	field :r_3, type: String, default: ""
	field :r_4, type: String, default: ""
	field :r_5, type: String, default: ""
end