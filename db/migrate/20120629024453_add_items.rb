class AddItems < ActiveRecord::Migration
  def up
    create_table :item_types do |t|
      t.string :name, :limit => 100, :null => false
      t.text :description
      t.decimal :radius
      t.decimal :mass
      t.decimal :volume
      t.decimal :capacity
      t.integer :units_per_run
      t.decimal :npc_price
      t.integer :item_type_group_id, :null => false
      t.integer :market_group_id
      t.timestamps
    end # types 
    
    create_table :item_type_groups do |t|
      t.string :name, :limit => 60, :null => false
      t.text :description
      t.boolean :manufacturable, :null => false
      t.boolean :recyclable, :null => false
      t.integer :item_type_category_id, :null => false
      t.timestamps
    end # groups

    create_table :item_type_categories do |t|
      t.string :name, :limit => 30, :null => false
      t.text :description
      t.timestamps
    end # categories
  end

  def down
    drop_table :item_types
    drop_table :item_type_groups
    drop_table :item_type_categories
  end
end
