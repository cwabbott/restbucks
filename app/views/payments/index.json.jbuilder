json.array!(@payments) do |payment|
  json.extract! payment, :id, :cardNo, :expires, :name, :amount
  json.url payment_url(payment, format: :json)
end
