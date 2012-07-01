class Item::Group < ActiveRecord::Base 
  belongs_to :category
  has_many :types
end
