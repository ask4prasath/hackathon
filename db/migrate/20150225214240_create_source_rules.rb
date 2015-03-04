class CreateSourceRules < ActiveRecord::Migration
  def change
    create_table :source_rules do |t|
      t.string :source_id
      t.string :name
      t.string :action
      t.string :value

      t.timestamps
    end
  end
end
