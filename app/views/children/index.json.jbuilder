json.array!(@children) do |child|
  json.extract! child, :id, :first_name, :last_name, :middle_name, :birthdate, :orphanage_id, :mentor_id
  json.url child_url(child, format: :json)
end
