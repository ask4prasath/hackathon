json.array!(@source_fields) do |source_field|
  json.extract! source_field, :id, :key_name, :field_type, :source_id
  json.url source_field_url(source_field, format: :json)
end
