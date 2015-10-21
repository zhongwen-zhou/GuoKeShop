require 'spreadsheet'

namespace :CaiPiao do
  desc '获取广东11选5数据'
  task :init_gd => :environment do

  	CaipiaoGd.destroy_all
  	date_today = Date.current
  	(1...180).each do |i|
  		date = date_today - i.days
  		date_str = date.strftime('%Y-%m-%d')
			url = "http://www.lecai.com/lottery/draw/view/22/#{date_str}?"
			Rails.logger.info "－－－－－－获取 #{date_str}－－－－－－广东11选5"

			response = HTTPClient.get(url).body()
			start_index = response.index('{"'+date_str+'":{')
			end_index = response.index('}}};')
			end_index = end_index+2
			json_result = JSON.parse(response[start_index..end_index])
			root_data = json_result[date_str]

			nos = root_data.keys
			nos.each do |no|
				current_results = root_data[no]['result']['red']
				gd_cp = CaipiaoGd.create(no: no, city_no: '广东')
				current_results.each_with_index do |result, index|
					gd_cp.update_attribute("r_#{index+1}", result)
				end
			end
  	end
  end
end
