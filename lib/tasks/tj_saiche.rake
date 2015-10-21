require 'spreadsheet'

namespace :CaiPiao do
  desc '分析赛车彩票数据'
  task :tj_saiche => :environment do

  	logger = Logger.new('log/saiche.log')

  	total_count = SaiCheMeta.count
		(1..10).each do |x|
			logger.info "分析第#{x}名:小数-#{SaiCheMeta.min("r_#{x}_small")}, 大数-#{SaiCheMeta.min("r_#{x}_big")}, 偶数-#{SaiCheMeta.min("r_#{x}_even")}, 奇数-#{SaiCheMeta.min("r_#{x}_odd")}"
			logger.info '分析数据:'

			(0..20).each do |i|
				small_count = SaiCheMeta.where("r_#{x}_bs_end" => true, "r_#{x}_small" => -i).count
				big_count = SaiCheMeta.where("r_#{x}_bs_end" => true, "r_#{x}_big" => -i).count
				even_count = SaiCheMeta.where("r_#{x}_oe_end" => true, "r_#{x}_even" => -i).count
				odd_count = SaiCheMeta.where("r_#{x}_oe_end" => true, "r_#{x}_odd" => -i).count

				str = "#{i} #{small_count}/#{(small_count/total_count.to_f*1000).to_s[0..5]} #{big_count}/#{(big_count/total_count.to_f*1000).to_s[0..5]} #{even_count}/#{(even_count/total_count.to_f*1000).to_s[0..5]} #{odd_count}/#{(odd_count/total_count.to_f*1000).to_s[0..5]}"
				logger.info str
			end
			logger.info '-------'
		end
  end



end
