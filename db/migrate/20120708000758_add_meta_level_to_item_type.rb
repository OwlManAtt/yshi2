class AddMetaLevelToItemType < ActiveRecord::Migration
  def change
    add_column :item_types, :metalevel, :integer
  end
end
