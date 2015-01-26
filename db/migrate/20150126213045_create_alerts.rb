class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|
      t.integer :source_id
      t.string :text

      t.timestamps
    end
  end
end
