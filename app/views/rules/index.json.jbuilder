json.array!(@rules) do |rule|
  json.extract! rule, :id, :source, :text
  json.url rule_url(rule, format: :json)
end
