require 'spreadsheet'

namespace :CaiPiao do
  desc '分析赛车彩票数据'
  task :tj_gd => :environment do

  	logger = Logger.new('log/caipiao_gd.log')

  	total_count = CaipiaoGdMeta.count
		('01'..'11').each do |x|
			logger.info "分析第#{x}名:遗漏-#{CaipiaoGdMeta.max("r_#{x}")}"
			logger.info '分析数据:'

			('01'..'20').each do |i|
				_count = CaipiaoGdMeta.where("r_#{x}_end" => true, "r_#{x}" => i).count

				str = "#{i} #{_count} #{(_count/total_count.to_f*1000).to_s[0..5]}"
				logger.info str
			end
			logger.info '-------'
		end
  end



end
