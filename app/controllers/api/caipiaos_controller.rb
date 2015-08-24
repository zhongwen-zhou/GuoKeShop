module Api
	class CaipiaosController < BaseController



		# 取得最新未购买的彩票
		def latest_caipiao
			wait_buy_caipiao = Caipiao.where(is_over: false, bought: false).order(created_at: :asc).first
			
			if wait_buy_caipiao.nil?
				return render json: false
			else
			
				render json: {code_no: wait_buy_caipiao.code_no, value: wait_buy_caipiao.genearte_code_template, city_no: wait_buy_caipiao.city_no}
			end
		end


		# 推送结果
		def push_last_result
			strValue = params[:strValue]
			return render json: true if strValue.empty?
			jsonData = JSON.parse(strValue)
			code_no = jsonData['2'][1]
			nums_str = jsonData['2'][2]
			city_no = jsonData['2'][3]
			nums = nums_str.split(",")
			# current_qishu = jsonData['5'][2]
			Caipiao.new_coming_data(city_no, code_no, nums)
			render json: true
		end

		# 购买彩票成功
		def bought
			caipiao = Caipiao.where(city_no: params[:city_no], code_no: params[:code_no]).first
			caipiao.bought = true
			caipiao.save

			render json: true
		end

		def my_money
			strValue = params[:strValue]
			jsonData = JSON.parse(strValue)
			Caipiao.setMoney(jsonData[1].to_f)
			render json: true
		end

		def money
			render text: Caipiao.getMoney
		end

	end
end