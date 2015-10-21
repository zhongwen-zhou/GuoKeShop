# 彩票模型
class SaiCheMeta
	include Mongoid::Document

	field :no, type: String, default: ""

	field :r_1, type: String, default: ""
	field :r_1_big, type: Integer, default: 0
	field :r_1_small, type: Integer, default: 0
	field :r_1_bs_end, type: Boolean, default: false	#大小结束
	field :r_1_odd, type: Integer, default: 0	#奇数
	field :r_1_even, type: Integer, default: 0	#偶数
	field :r_1_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_2, type: String, default: ""
	field :r_2_big, type: Integer, default: 0
	field :r_2_small, type: Integer, default: 0
	field :r_2_bs_end, type: Boolean, default: false	#大小结束
	field :r_2_odd, type: Integer, default: 0	#奇数
	field :r_2_even, type: Integer, default: 0	#偶数
	field :r_2_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_3, type: String, default: ""
	field :r_3_big, type: Integer, default: 0
	field :r_3_small, type: Integer, default: 0
	field :r_3_bs_end, type: Boolean, default: false	#大小结束
	field :r_3_odd, type: Integer, default: 0	#奇数
	field :r_3_even, type: Integer, default: 0	#偶数
	field :r_3_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_4, type: String, default: ""
	field :r_4_big, type: Integer, default: 0
	field :r_4_small, type: Integer, default: 0
	field :r_4_bs_end, type: Boolean, default: false	#大小结束
	field :r_4_odd, type: Integer, default: 0	#奇数
	field :r_4_even, type: Integer, default: 0	#偶数
	field :r_4_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_5, type: String, default: ""
	field :r_5_big, type: Integer, default: 0
	field :r_5_small, type: Integer, default: 0
	field :r_5_bs_end, type: Boolean, default: false	#大小结束
	field :r_5_odd, type: Integer, default: 0	#奇数
	field :r_5_even, type: Integer, default: 0	#偶数
	field :r_5_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_6, type: String, default: ""
	field :r_6_big, type: Integer, default: 0
	field :r_6_small, type: Integer, default: 0
	field :r_6_bs_end, type: Boolean, default: false	#大小结束
	field :r_6_odd, type: Integer, default: 0	#奇数
	field :r_6_even, type: Integer, default: 0	#偶数
	field :r_6_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_7, type: String, default: ""
	field :r_7_big, type: Integer, default: 0
	field :r_7_small, type: Integer, default: 0
	field :r_7_bs_end, type: Boolean, default: false	#大小结束
	field :r_7_odd, type: Integer, default: 0	#奇数
	field :r_7_even, type: Integer, default: 0	#偶数
	field :r_7_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_8, type: String, default: ""
	field :r_8_big, type: Integer, default: 0
	field :r_8_small, type: Integer, default: 0
	field :r_8_bs_end, type: Boolean, default: false	#大小结束
	field :r_8_odd, type: Integer, default: 0	#奇数
	field :r_8_even, type: Integer, default: 0	#偶数
	field :r_8_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_9, type: String, default: ""
	field :r_9_big, type: Integer, default: 0
	field :r_9_small, type: Integer, default: 0
	field :r_9_bs_end, type: Boolean, default: false	#大小结束
	field :r_9_odd, type: Integer, default: 0	#奇数
	field :r_9_even, type: Integer, default: 0	#偶数
	field :r_9_oe_end, type: Boolean, default: false	#奇偶结束

	field :r_10, type: String, default: ""	
	field :r_10_big, type: Integer, default: 0
	field :r_10_small, type: Integer, default: 0
	field :r_10_bs_end, type: Boolean, default: false	#大小结束
	field :r_10_odd, type: Integer, default: 0	#奇数
	field :r_10_even, type: Integer, default: 0	#偶数	
	field :r_10_oe_end, type: Boolean, default: false	#奇偶结束
end