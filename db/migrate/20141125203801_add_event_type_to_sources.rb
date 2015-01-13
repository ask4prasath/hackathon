class AddEventTypeToSources < ActiveRecord::Migration
  def change
    add_column :sources, :event_type, :string
  end
end
