json.array!(@drinks) do |drink|
  json.extract! drink, :id, :drink, :cost
  json.url drink_url(drink, format: :json)
end
