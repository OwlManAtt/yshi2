class Item::TypeGroup < ActiveRecord::Base 
  belongs_to :type_category
  has_many :types
end
