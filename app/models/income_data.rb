# 来源数据
class IncomeData
	include Mongoid::Document
	include Mongoid::Timestamps

	# 城市(广州11选5)
	field :city, type: String
	field :city_no, type: Integer
	# 期数
	field :code_no, type: String

	field :num_1, type: Integer
	field :num_2, type: Integer
	field :num_3, type: Integer
	field :num_4, type: Integer
	field :num_5, type: Integer

	def nums
		[num_1, num_2, num_3, num_4, num_5]
	end

	after_save :process_new_data

	def process_new_data
		win_or_lost
		generate_next_caipiao
	end

	# 是否中奖
	def win_or_lost
		Caipiao.win_or_lost(city_no, code_no)
	end


	# 生成下一个推荐数
	def generate_next_caipiao
		Caipiao.generate_next_caipiao(city_no, code_no, nums)
	end
end