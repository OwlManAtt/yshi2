class Item::Category < ActiveRecord::Base 
  has_many :groups
end
