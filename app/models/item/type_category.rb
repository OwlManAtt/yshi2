class Item::TypeCategory < ActiveRecord::Base 
  has_many :type_groups
end
