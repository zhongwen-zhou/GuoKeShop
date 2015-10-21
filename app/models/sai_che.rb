# 彩票模型
class SaiChe
	include Mongoid::Document

	field :no, type: String, default: ""
	field :r_1, type: String, default: ""
	field :r_2, type: String, default: ""
	field :r_3, type: String, default: ""
	field :r_4, type: String, default: ""
	field :r_5, type: String, default: ""
	field :r_6, type: String, default: ""
	field :r_7, type: String, default: ""
	field :r_8, type: String, default: ""
	field :r_9, type: String, default: ""
	field :r_10, type: String, default: ""	
end