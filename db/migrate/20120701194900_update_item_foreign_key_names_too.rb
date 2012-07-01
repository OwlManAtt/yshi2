class UpdateItemForeignKeyNamesToo < ActiveRecord::Migration
  def change 
    rename_column :item_types, :item_group_id, :group_id
    rename_column :item_groups, :item_category_id, :category_id
  end
end
