json.array!(@orphanages) do |orphanage|
  json.extract! orphanage, :id, :name, :address
  json.url orphanage_url(orphanage, format: :json)
end
