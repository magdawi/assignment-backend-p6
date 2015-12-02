json.array!(@incomes) do |income|
  json.extract! income, :id, :note, :date, :sum, :category_id, :pocket_id, :user_id
  json.url income_url(income, format: :json)
end
