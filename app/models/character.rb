class Character < ActiveRecord::Base
  belongs_to :corporation
  belongs_to :user
  # attr_accessible :title, :body
end
