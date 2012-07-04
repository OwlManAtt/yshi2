class Item::Blueprint < ActiveRecord::Base
  belongs_to :type
  belongs_to :product_type, :class_name => 'Item::Type', :foreign_key => :product_type_id 

  has_many :materials, :through => :blueprint_materials, :class_name => :type, :foreign_key => :material_type_id 
end
