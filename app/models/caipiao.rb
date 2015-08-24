# 彩票模型
class Caipiao
	include Mongoid::Document
	include Mongoid::Timestamps


	CITY_GUANGDONG = 7	# 广东11选5
	CITY_SHANGHAI = 8		# 上海11选5
	CITY_SHANDONG = 9		# 山东11选5
	CITY_JIANGXI = 10		# 江西11选5

	# 策略
	STRATEGY_HEAD_RANDOM = 0		# 上把首2个任选1
	STRATEGY_TAIL_RANDOM = 1		# 上把尾2个任选1
	STRATEGY_HEAD_PLUS = 2			# 上把首数+1
	STRATEGY_TONY = 3						# tone推荐算法

	CITIES = {'7' => '广东', '8' => '上海', '9' => '山东', '10' => '江西'}

	field :city_no, type: Integer, default: 0
	field :city, type: String, default: ""

	field :code_no, type: String, default: ""
	field :recommend_num, type: Integer, default: 4
	field :strategy, type: Integer, default: 0
	
	field :is_winning, type: Boolean, default: false
	field :remark, type: String, default: ""
	field :bought, type: Boolean, default: false

	field :s_1_value, type: Integer, default: 0
	field :is_s_1_winning, type: Boolean, default: false
	
	field :s_2_value, type: Integer, default: 0
	field :is_s_2_winning, type: Boolean, default: false
	
	field :s_3_value, type: Integer, default: 0
	field :is_s_3_winning, type: Boolean, default: false
	
	field :s_4_value, type: Integer, default: 0
	field :is_s_4_winning, type: Boolean, default: false

	field :is_over, type: Boolean, default: false

	field :times, type: Integer, default: 1

	@@_money = 0

	@@_hot_nums = {'7' => {'11' => 53, '1' => 50, '7' => 49},
								 '8' => {'1' => 49, '4' => 49, '5' => 48},
								 '9' => {'3' => 50, '11' => 50, '9' => 48},
								 '10' => {'5' => 54, '10' =>49, '4' => 48}
								}

	@@_multiple = {'7' => {'11' => 0, '1' => 0, '7' => 0},
								 '8' => {'1' => 0, '4' => 0, '5' => 0},
								 '9' => {'3' => 0, '11' => 0, '9' => 0},
								 '10' => {'5' => 0, '10' =>0, '4' => 0}
								}
					
	@@_max_double = 5				

	def self.setMoney(money)
		@@_money = money
	end

	def self.getMoney
		@@_money
	end

	def self.new_coming_data(city_no, code_no, nums)

		caipiao_data = IncomeData.where(city_no: city_no, code_no: code_no).first
		return if caipiao_data
		Caipiao.where(city_no: city_no).update_all(is_over: true)
		caipiao_data = IncomeData.new
		caipiao_data.city_no = city_no
		caipiao_data.city = CITIES[city_no.to_s]
		caipiao_data.code_no = code_no


		caipiao_data.num_1 = nums[0]
		caipiao_data.num_2 = nums[1]
		caipiao_data.num_3 = nums[2]
		caipiao_data.num_4 = nums[3]
		caipiao_data.num_5 = nums[4]


		caipiao_data.save

	end

  def last_caipiao
  	last_caipiao = Caipiao.where(city_no: city_no).order(created_at: :desc).first
  end

	def win_nums
		IncomeData.where(city_no: self.city_no, code_no: self.code_no).first.nums
	end

	def self.win_or_lost(city_no, code_no)
		caipiao = Caipiao.where(city_no: city_no, code_no: code_no).first
		return if caipiao.nil?
		win_nums = caipiao.win_nums
		index = win_nums.index caipiao.recommend_num
		win = !(index.nil?)
		caipiao.is_winning = win


		multiple_nums = @@_multiple[city_no.to_s]
		multiple_nums[caipiao.recommend_num.to_s] = 0 if win

		caipiao.is_s_1_winning = !(win_nums.index(caipiao.s_1_value)).nil?
		caipiao.is_s_2_winning = !(win_nums.index(caipiao.s_2_value)).nil?
		caipiao.is_s_3_winning = !(win_nums.index(caipiao.s_3_value)).nil?
		caipiao.is_s_4_winning = !(win_nums.index(caipiao.s_4_value)).nil?

		caipiao.save
	end


	# 首数任选

	def genearte_caipiao_by_head_randomx(city_no, win_nums)
		recommend_num = win_nums[Random.new.rand(2)]
	end


	# 尾数任选
	def genearte_caipiao_by_tail_randomx(city_no, win_nums)
		random_index = Random.new.rand(2)
		recommend_num = win_nums[random_index+4]
	end


	# 首数相加
	def genearte_caipiao_by_head_plusx(city_no, win_nums)
		recommend_num = win_nums[0]+1
	end


	# tone算法
	def genearte_caipiao_by_tonex(city_no, win_nums)
		# win_nums = last_caipiao.win_nums
		first_num = win_nums[1]
		second_num = win_nums[2]
		if first_num == 11 || second_num == 11
			recommend_num = [first_num, second_num].select{|x| x != 11}[0]
			recommend_num = recommend_num + 1
		else
			recommend_num = (first_num + second_num) % 11
		end
		

		recommend_num
	end	

	def self.generate_next_caipiao(city_no, code_no, win_nums)

		new_caipiao = Caipiao.new

		new_caipiao.city_no = city_no
		new_caipiao.city = CITIES[city_no.to_s]
		new_caipiao.code_no = code_no.next


		strategy = Random.new.rand(4)
		new_caipiao.s_1_value = new_caipiao.genearte_caipiao_by_head_randomx(city_no, win_nums)
		new_caipiao.s_2_value = new_caipiao.genearte_caipiao_by_tail_randomx(city_no, win_nums)
		new_caipiao.s_3_value = new_caipiao.genearte_caipiao_by_head_plusx(city_no, win_nums)
		new_caipiao.s_4_value = new_caipiao.genearte_caipiao_by_tonex(city_no, win_nums)

		# good_luck_numbs = [new_caipiao.s_1_value, new_caipiao.s_2_value, new_caipiao.s_3_value, new_caipiao.s_4_value]
		# new_caipiao.recommend_num = good_luck_numbs[strategy] || 4
		# new_caipiao.strategy = strategy

		nums = @@_multiple[city_no.to_s]	# 取热数
		current_time = nums.values.max 		# 取当期最大倍数
		current_num = nums.select {|x| nums[x] == current_time}	# 取得号码
		current_num = current_num.keys.first
		times = 1
		current_time.times do
			times = times * 2
		end

		p '!!!!'
		p current_num


		new_caipiao.recommend_num = current_num.to_i || 4
		new_caipiao.strategy = 9

		current_time = 0 if current_time > @@_max_double	#恢复0
		nums[current_num.to_s] = current_time + 1

		new_caipiao.save
		return new_caipiao
	end

	def genearte_code_template
		otype = 1	# 不清楚
		recommend_num_str = recommend_num > 9 ? recommend_num.to_s : "0#{recommend_num}"
		unit = 2 # 角

		string_template = "#{city_no}%0%1%#{otype}%#{code_no},1%3016^4.26^#{recommend_num_str}^#{times}^1^#{unit}^0"
	end







	def self.test1

		Caipiao.destroy_all
		IncomeData.destroy_all

	end

	def self.init_data(code_no)
		CITIES.keys.each do |city_no|
			c = Caipiao.new
			c.city_no = city_no.to_i
			c.city = CITIES[city_no]
			c.code_no = code_no
			c.strategy = 1
			c.recommend_num = 4

			c.s_1_value = 1
			c.s_2_value = 2
			c.s_3_value = 3
			c.s_4_value = 4
			c.save
		end
	end


	def self.test

		Caipiao.destroy_all
		IncomeData.destroy_all

		c = Caipiao.new
		c.city_no = 10
		c.city = '江西'
		c.code_no = '2015082301'
		c.strategy = 1
		c.recommend_num = 4

		c.s_1_value = 1
		c.s_2_value = 2
		c.s_3_value = 3
		c.s_4_value = 4
		c.save

		i1 = IncomeData.new
		i1.city_no = c.city_no
		i1.city = c.city
		i1.code_no = c.code_no

		i1.num_1 = 2
		i1.num_2 = 3
		i1.num_3 = 4
		i1.num_4 = 5
		i1.num_5 = 6

		i1.save

	end

	if false



		require 'net/http'
		Net::HTTP.version_1_2
		Net::HTTP.start('http://cbot5.cbin777.com/z/00', 8088) do |http|
		  response = http.post('b=1430222725650,1440255482533,8,1440223303')
		end



		require 'net/http'

		url = URI.parse('http://cbot5.cbin777.com:8088/z/00')

		Net::HTTP.start(url.host, url.port) do |http|
		  req = Net::HTTP::Post.new(url.path)
		  req.set_form_data({ 'b' => '1430222725650,1440255482533,8,1440223303' })
		  puts http.request(req).body
		end

		@@max_gl = 2

		def self.getInstance
			cp = Caipiao.last || Caipiao.new
			cp.save!
			cp
		end

		def self.setCurrentQiShu(qishu, haoma, current_qishu)

			caipiao_instance = getInstance
			caipiao_instance.update_attribute("current_qishu", current_qishu)

			p "分析 广东11选5 第 #{qishu} 是否加入纪录！"



			if qishu != getInstance.last_qishu
				p "加入 第 #{qishu} 中奖号码"

				cpData = IncomeData.new
				cpData.title = "广州11选5"

				cpData.no = qishu

				haomas = haoma.split(",")

				cpData.num_1 = haomas[0]
				cpData.num_2 = haomas[1]
				cpData.num_3 = haomas[2]
				cpData.num_4 = haomas[3]
				cpData.num_5 = haomas[4]
				cpData.save!


				(1..11).each do |index|
					caipiao_instance.inc("num_#{index}" => 1)
				end

				haomas.each do |haoma|
					haoma = haoma.to_i
					caipiao_instance.update_attribute("num_#{haoma}", 0)
				end

				caipiao_instance.update_attribute("bought", false)
				caipiao_instance.update_attribute("last_qishu", qishu)

				caipiao_instance.save!

			else
				p "已经加入，不再处理！"
			end
		end

		def getLaw
			nums = [num_1, num_2, num_3, num_4, num_5, num_6, num_7, num_8, num_9, num_10, num_11]
		end

		def self.getCurrentQiShu
			current_qishu
		end

		def self.getLastQiShu
			last_qishu
		end

		# 生成选1号码
		def createCode

			if !bought
				nums = [num_1, num_2, num_3, num_4, num_5, num_6, num_7, num_8, num_9, num_10, num_11]
				max_value = nums.max
				max_index = nums.index max_value

				p "当前 最大不中数是：#{max_index}，不连中期数为：#{max_value}"

				last_data = IncomeData.last
				temp_data = last_data.num_2 + last_data.num_3


				if true
					if max_value > @@max_gl

						p "最大不连中期数为: #{max_value}，超过 #{@@max_gl} 次，推荐购买"

						code = max_index + 1

						p "max_index: #{max_index}"
						p "code: #{code}"

						code = "0#{code}" if code < 10

						code = temp_data%11

						p "code2: #{code}"

						city_id = 7 # 广州11选5

						otype = 1	# 不清楚

						string_temp = "#{city_id}%0%1%#{otype}%#{current_qishu},1%3016^4.26^#{code}^1^1^1^0"

						last_qishu = current_qishu

						p "选号成功，推荐为: #{code}"

						self.bought = true
						self.save!
						string_temp
					else
						false
					end
				end
			else
				false
			end
		end

	end

end