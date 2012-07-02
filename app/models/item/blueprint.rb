class Item::Blueprint < ActiveRecord::Base
  belongs_to :type
  belongs_to :product_type, :class_name => 'Item::Type', :foreign_key => :product_type_id 
end
