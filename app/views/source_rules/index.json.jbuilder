json.array!(@source_rules) do |source_rule|
  json.extract! source_rule, :id, :source, :name, :action, :value
  json.url source_rule_url(source_rule, format: :json)
end
