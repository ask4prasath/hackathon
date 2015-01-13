class CreateSourceFields < ActiveRecord::Migration
  def change
    create_table :source_fields do |t|
      t.string :key_name
      t.string :field_type
      t.references :source, index: true

      t.timestamps
    end
  end
end
