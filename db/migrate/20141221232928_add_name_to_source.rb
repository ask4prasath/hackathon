class AddNameToSource < ActiveRecord::Migration
  def change
    add_column :sources, :validation, :boolean
  end
end
