class AddTechLevelToItemTypes < ActiveRecord::Migration
  def change
    add_column :item_types, :techlevel, :integer
  end
end
