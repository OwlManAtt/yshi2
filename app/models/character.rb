class Character < ActiveRecord::Base
  belongs_to :corporation
  belongs_to :user
  belongs_to :api_key
end
