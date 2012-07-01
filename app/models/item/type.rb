class Item::Type < ActiveRecord::Base 
  belongs_to :group

  [:manufacturable?, :recyclable?].each { |method| delegate method, :to => :group, :allow_nil => true }
end
