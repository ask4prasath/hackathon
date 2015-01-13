class AddValidationToSourceFields < ActiveRecord::Migration
  def change
    add_column :source_fields, :required, :boolean
    add_column :source_fields, :min_length, :integer
    add_column :source_fields, :max_length, :integer
    add_column :source_fields, :space_allowed, :boolean
    add_column :source_fields, :default_value, :string
  end
end
