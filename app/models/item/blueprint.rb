class Item::Blueprint < ActiveRecord::Base
  belongs_to :blueprint_type, :class_name => 'Item::Type', :foreign_key => :id
  belongs_to :product_type, :class_name => 'Item::Type', :foreign_key => :product_type_id 

  has_many :blueprint_materials, :foreign_key => :material_type_id
  has_many :materials, :through => :blueprint_materials, :class_name => 'Item::Type', :foreign_key => :material_type_id 

  has_many :blueprint_skills, :foreign_key => :skill_type_id
  has_many :skills, :through => :blueprint_skills, :class_name => 'Item::Type', :foreign_key => :skill_type_id
end
