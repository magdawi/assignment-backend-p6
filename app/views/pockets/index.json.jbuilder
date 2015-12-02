json.array!(@pockets) do |pocket|
  json.extract! pocket, :id, :name, :user_id
  json.url pocket_url(pocket, format: :json)
end
