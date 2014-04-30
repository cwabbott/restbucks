json.array!(@orders) do |order|
  json.extract! order, :id, :drink
  json.url order_url(order, format: :json)
end
