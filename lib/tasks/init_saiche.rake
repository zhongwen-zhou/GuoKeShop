require 'spreadsheet'

namespace :CaiPiao do
  desc '获取赛车彩票数据'
  task :init_saiche => :environment do

  	SaiChe.destroy_all
  	date_today = Date.current
  	(1...180).each do |i|
  		date = date_today - i.days
  		date_str = date.strftime('%Y-%m-%d')
			url = "http://www.lecai.com/lottery/draw/view/557/#{date_str}?"
			Rails.logger.info "－－－－－－获取 #{date_str}－－－－－－赛车数据"

			response = HTTPClient.get(url).body()
			start_index = response.index('{"'+date_str+'":{')
			end_index = response.index('}}};')
			end_index = end_index+2
			json_result = JSON.parse(response[start_index..end_index])
			root_data = json_result[date_str]
			nos = root_data.keys
			nos.each do |no|
				current_results = root_data[no]['result']['red']
				sai_che = SaiChe.create(no: no)
				current_results.each_with_index do |result, index|
					sai_che.update_attribute("r_#{index+1}", result)
				end
			end
  	end
  end
end
