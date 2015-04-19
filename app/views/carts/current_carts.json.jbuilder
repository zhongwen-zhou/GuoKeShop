json.item_count 8
json.total_price 8
json.transport_price 3
json.items @items do |item|
  json.id item[:id]
  json.count item[:count]
  json.price item[:price]
end