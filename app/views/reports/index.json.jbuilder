json.array!(@reports) do |report|
  json.extract! report, :id, :text, :state, :meeting_id
  json.url report_url(report, format: :json)
end
