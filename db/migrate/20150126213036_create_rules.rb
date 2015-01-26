class CreateRules < ActiveRecord::Migration
  def change
    create_table :rules do |t|
      t.integer :source_id
      t.string :text

      t.timestamps
    end
  end
end
