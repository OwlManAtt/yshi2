class Item::BlueprintMaterial < ActiveRecord::Base 
  belongs_to :blueprint, :class_name => 'Item::Type', :foreign_key => :blueprint_type_id
  belongs_to :material, :class_name => 'Item::Type', :foreign_key => :material_type_id
 
end
