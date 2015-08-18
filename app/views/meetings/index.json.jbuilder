json.array!(@meetings) do |meeting|
  json.extract! meeting, :id, :date, :state, :child_id, :mentor
  json.url meeting_url(meeting, format: :json)
end
