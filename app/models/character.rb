class Character < ActiveRecord::Base
  include FromApi

  attr_accessible :eve_id, :name

  belongs_to :corporation
  belongs_to :user
  belongs_to :api_key
end
