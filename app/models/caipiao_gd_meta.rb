# 彩票模型
class CaipiaoGdMeta
	include Mongoid::Document

	field :no, type: String, default: ""

	field :r_01, type: Integer, default: 0
	field :r_01_lost, type: Integer, default: 0
	field :r_01_end, type: Boolean, default: false	#遗漏结束

	# field :r_2, type: String, default: ""
	field :r_02, type: Integer, default: 0
	field :r_02_lost, type: Integer, default: 0
	field :r_02_end, type: Boolean, default: false	#遗漏结束	

	# field :r_3, type: String, default: ""
	field :r_03, type: Integer, default: 0
	field :r_03_lost, type: Integer, default: 0
	field :r_03_end, type: Boolean, default: false	#遗漏结束	

	# field :r_4, type: String, default: ""
	field :r_04, type: Integer, default: 0
	field :r_04_lost, type: Integer, default: 0
	field :r_04_end, type: Boolean, default: false	#遗漏结束	

	# field :r_5, type: String, default: ""
	field :r_05, type: Integer, default: 0
	field :r_05_lost, type: Integer, default: 0
	field :r_05_end, type: Boolean, default: false	#遗漏结束	

	# field :r_6, type: String, default: ""
	field :r_06, type: Integer, default: 0
	field :r_06_lost, type: Integer, default: 0
	field :r_06_end, type: Boolean, default: false	#遗漏结束	

	# field :r_7, type: String, default: ""
	field :r_07, type: Integer, default: 0
	field :r_07_lost, type: Integer, default: 0
	field :r_07_end, type: Boolean, default: false	#遗漏结束	

	# field :r_8, type: String, default: ""
	field :r_08, type: Integer, default: 0
	field :r_08_lost, type: Integer, default: 0
	field :r_08_end, type: Boolean, default: false	#遗漏结束	

	# field :r_9, type: String, default: ""
	field :r_09, type: Integer, default: 0
	field :r_09_lost, type: Integer, default: 0
	field :r_09_end, type: Boolean, default: false	#遗漏结束	

	# field :r_10, type: String, default: ""
	field :r_10, type: Integer, default: 0
	field :r_10_lost, type: Integer, default: 0
	field :r_10_end, type: Boolean, default: false	#遗漏结束						

	# field :r_11, type: String, default: ""
	field :r_11, type: Integer, default: 0
	field :r_11_lost, type: Integer, default: 0
	field :r_11_end, type: Boolean, default: false	#遗漏结束		
end