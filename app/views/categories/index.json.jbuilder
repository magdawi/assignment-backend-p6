json.array!(@categories) do |category|
  json.extract! category, :id, :name, :way, :user_id
  json.url category_url(category, format: :json)
end
