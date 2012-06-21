class Corporation < ActiveRecord::Base
  has_many :users
  has_many :characters
  # attr_accessible :title, :body
end
