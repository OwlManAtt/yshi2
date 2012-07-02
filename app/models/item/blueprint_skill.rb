class Item::BlueprintSkill < ActiveRecord::Base 
  belongs_to :blueprint, :class_name => 'Item::Type', :foreign_key => :blueprint_type_id
  belongs_to :skill, :class_name => 'Item::Type', :foreign_key => :skill_type_id
end
