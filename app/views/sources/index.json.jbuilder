json.array!(@sources) do |source|
  json.extract! source, :id, :name, :source_id, :api
  json.url source_url(source, format: :json)
end
