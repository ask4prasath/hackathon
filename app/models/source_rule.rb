class SourceRule < ActiveRecord::Base


  belongs_to :source
  HBASE_CLIENT = Stargate::Client.new("http://localhost:12323")

end
