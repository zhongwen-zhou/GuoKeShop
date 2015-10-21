require 'spreadsheet'

namespace :CaiPiao do
  desc '分析赛车彩票数据'
  task :analy_gd => :environment do

  	CaipiaoGdMeta.destroy_all

  	CaipiaoGd.order(no: :asc).each do |caipiao|
  		caipiao_meta = CaipiaoGdMeta.create(no: caipiao.no)

  		p "－－－开始分析#{caipiao.no} --数据"
	  	last_caipiao = CaipiaoGd.where(:no.lt => caipiao.no).order(no: :desc).first
	  	next unless last_caipiao
	  	last_caipiao_meta = CaipiaoGdMeta.where(no: last_caipiao.no).first
	  	last_rs = [last_caipiao.r_1, last_caipiao.r_2, last_caipiao.r_3, last_caipiao.r_4, last_caipiao.r_5]
	  	current_rs = [caipiao.r_1, caipiao.r_2, caipiao.r_3, caipiao.r_4, caipiao.r_5]
  		('01'..'11').each do |x|
	  		caipiao_meta.update_attribute("r_#{x}_lost", last_caipiao_meta["r_#{x}_lost"]+1)
	  	end

	  	current_rs.each do |current_r|
	  		if last_rs.index current_r
	  			# 这次出现的数上次也出现过，即没有遗漏
	  		else
		  		caipiao_meta.update_attribute("r_#{current_r}", last_caipiao_meta["r_#{current_r}_lost"])
		  		caipiao_meta.update_attribute("r_#{current_r}_lost", 0)
		  		caipiao_meta.update_attribute("r_#{current_r}_end", true)
	  		end
	  	end
  	end
  end
end
