json.array!(@calendars) do |calendar|
  json.extract! calendar, :id, :period, :sum_income, :sum_outgoing, :balance, :pocket_id, :user_id
  json.url calendar_url(calendar, format: :json)
end
