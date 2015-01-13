require 'stargate'

class CreateHbaseTable < ActiveRecord::Migration
  def change
    @client = Stargate::Client.new("http://localhost:12323")
    @client.create_table "source", "metadata", "fields"
    @client.create_table "apiRequestTable", "success", "failed"
  end
end
