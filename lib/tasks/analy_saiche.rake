require 'spreadsheet'

namespace :CaiPiao do
  desc '分析赛车彩票数据'
  task :analy_saiche => :environment do

  	SaiCheMeta.destroy_all

  	SaiChe.order(no: :asc).each do |sai_che|
  		sai_che_meta = SaiCheMeta.create(no: sai_che.no)

  		p "－－－开始分析#{sai_che.no} --数据"
  		(1..10).each do |x|
	  		sai_che_meta.update_attribute("r_#{x}", sai_che["r_#{x}"])
	  	end
	  	last_saiche = SaiChe.where(no: "#{sai_che.no.to_i-1}").first
	  	next unless last_saiche
	  	if(last_saiche)
		  	last_saiche_meta = SaiCheMeta.where(no: "#{sai_che.no.to_i-1}").first
		  	next unless last_saiche_meta
	  		(1..10).each do |x|
	  			last_r = last_saiche["r_#{x}"]
	  			current_r = sai_che["r_#{x}"]

	  			if(last_r > '05')
	  				# 上次为大
	  				if(current_r > '05')
	  					# 这次也为大
	  					sai_che_meta.update_attribute("r_#{x}_big", last_saiche_meta["r_#{x}_big"]+1)
	  				else
	  					# 这次为小
	  					sai_che_meta.update_attribute("r_#{x}_small", 1)
	  					sai_che_meta.update_attribute("r_#{x}_big", -last_saiche_meta["r_#{x}_big"])
	  					sai_che_meta.update_attribute("r_#{x}_bs_end", true)
	  				end
	  			else
	  				# 上次为小
	  				if(current_r < '06')
	  					# 这次也为小
	  					sai_che_meta.update_attribute("r_#{x}_small", last_saiche_meta["r_#{x}_small"]+1)
	  				else
	  					# 这次为大
	  					sai_che_meta.update_attribute("r_#{x}_big", 1)
	  					sai_che_meta.update_attribute("r_#{x}_small", -last_saiche_meta["r_#{x}_small"])
	  					sai_che_meta.update_attribute("r_#{x}_bs_end", true)
	  				end
	  			end

	  			if(last_r.to_i.even?)
	  				# 上次为偶数
	  				if(current_r.to_i.even?)
	  					# 这次也为偶数
	  					sai_che_meta.update_attribute("r_#{x}_even", last_saiche_meta["r_#{x}_even"]+1)
	  				else
	  					sai_che_meta.update_attribute("r_#{x}_odd", 1)
	  					sai_che_meta.update_attribute("r_#{x}_even", -last_saiche_meta["r_#{x}_even"])
	  					sai_che_meta.update_attribute("r_#{x}_oe_end", true)
	  					# 这次为奇数
	  				end
	  			else
	  				# 上次为奇数
	  				if(current_r.to_i.odd?)
	  					# 这次也为奇数
	  					sai_che_meta.update_attribute("r_#{x}_odd", last_saiche_meta["r_#{x}_odd"]+1)
	  				else
	  					# 这次为偶数
	  					sai_che_meta.update_attribute("r_#{x}_even", 1)
	  					sai_che_meta.update_attribute("r_#{x}_odd", -last_saiche_meta["r_#{x}_odd"])
	  					sai_che_meta.update_attribute("r_#{x}_oe_end", true)
	  				end
	  			end
		  	end	  		
	  	end
  	end
  end
end
