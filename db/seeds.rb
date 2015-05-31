# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


jiu = Category.create(name: '酒', level: 1)
['白酒','洋酒','啤酒','其他'].each do |name|
	Category.create(name: name, level: 2, parent: jiu)
end
yl = Category.create(name: '饮料', level: 1)
['碳酸饮料','果汁','矿泉水','奶饮品','其他'].each do |name|
	Category.create(name: name, level: 2, parent: yl)
end
ls = Category.create(name: '零食', level: 1)
['饼干类','面包、派','薯片','水果干活','冰淇淋','肉类','果类','糖类','方便食品'].each do |name|
	Category.create(name: name, level: 2, parent: ls)
end

qita = Category.create(name: '其他', level: 1)
['生活用品'].each do |name|
	Category.create(name: name, level: 2, parent: qita)
end