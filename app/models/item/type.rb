class Item::Type < ActiveRecord::Base 
  belongs_to :type_group

  [:manufacturable?, :recyclable?].each { |method| delegate method, :to => :type_group, :allow_nil => true }
end
