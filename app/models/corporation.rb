class Corporation < ActiveRecord::Base
  include FromApi

  attr_accessible :eve_id, :name

  has_many :users
  has_many :characters
  # attr_accessible :title, :body
end
