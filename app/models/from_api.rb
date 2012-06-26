module FromApi
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def find_or_create(attr)
      self.where(:eve_id => attr[:eve_id]).last || self.create!(attr)
    end # find_or_create
  end
end
