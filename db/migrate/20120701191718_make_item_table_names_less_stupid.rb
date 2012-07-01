class MakeItemTableNamesLessStupid < ActiveRecord::Migration
  def change 
    rename_table :item_type_groups, :item_groups
    rename_table :item_type_categories, :item_categories

    rename_column :item_groups, :item_type_category_id, :item_category_id
    rename_column :item_types, :item_type_group_id, :item_group_id
  end
end
