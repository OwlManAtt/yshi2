class Item::BlueprintMaterial < ActiveRecord::Base 
  self.inheritance_column = nil # type is used for something else

  belongs_to :blueprint, :class_name => 'Item::Type', :foreign_key => :blueprint_type_id
  belongs_to :material, :class_name => 'Item::Type', :foreign_key => :material_type_id
 
end
