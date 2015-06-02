require 'spreadsheet'

namespace :init_data do
  desc '初始化商品排序数据'
  task :order_index => :environment do
  	Category.where(level: 2).each do |category|
  		Item.where(category: category).each_with_index do |item, index|
  			item.set(order_index: index + 1)
  		end
  	end
  end
end
