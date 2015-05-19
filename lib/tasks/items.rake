require 'spreadsheet'

namespace :init_data do
  desc '初始化商品数据'
  task :items => :environment do
		Spreadsheet.client_encoding = 'UTF-8'
		book = Spreadsheet.open 'public/datas/items.xls'
		sheet = book.worksheets.first

		sheet.each_with_index do |row, index|
			next if index == 0
			p "index:#{index}"
			item = Item.new
			item.bar_code = row[0]
			item.cover_path = "items/#{item.bar_code}/1.jpg"
			category = Category.where(name: row[1]).first
			item.category = category
			item.top_category_id = category.parent_id
			item.name = row[2]
			item.units = row[3]
			item.in_price = row[4] || 0
			item.price = row[7] || 0
			item.desc = row[12]

			item.save!
		end
  end
end
