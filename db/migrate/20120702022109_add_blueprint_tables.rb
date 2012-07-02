class AddBlueprintTables < ActiveRecord::Migration
  def change 
    create_table :item_blueprints do |t|
      t.integer :blueprint_type_id, :null => false
      t.integer :product_type_id, :null => false
      t.integer :production_time
      t.integer :productivity_modifier
      t.integer :waste_factor
      t.integer :production_limit
      t.integer :research_material_time
      t.integer :research_productivity_time
      t.integer :copy_time
    end 

    create_table :item_blueprint_materials do |t|
      t.integer :blueprint_type_id, :null => false
      t.integer :material_type_id, :null => false
      t.integer :quantity, :null => false
      t.float :damage_per_job, :default => 1.0
      t.string :type, :null => false
    end

    create_table :item_blueprint_skills do |t|
      t.integer :blueprint_type_id, :null => false
      t.integer :skill_type_id, :null => false
      t.integer :minimum_level, :null => false
    end
  end
end
