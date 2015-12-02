json.array!(@outgoings) do |outgoing|
  json.extract! outgoing, :id, :note, :date, :sum, :category_id, :pocket_id, :user_id
  json.url outgoing_url(outgoing, format: :json)
end
