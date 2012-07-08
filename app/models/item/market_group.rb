class Item::MarketGroup < ActiveRecord::Base
  include ActsAsTree
  acts_as_tree

  has_many :types
end
