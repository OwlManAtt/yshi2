class AddBlueprintFlagToItemType < ActiveRecord::Migration
  def change
    add_column :item_types, :blueprint, :boolean, :default => false, :null => false
  end
end
