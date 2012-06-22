class User < ActiveRecord::Base
  belongs_to :corporation
  has_many :characters

  attr_accessible :name, :deleted, :corporation

  validates_presence_of :name
  validates_length_of :name, :in => 6..60
  
  validates_presence_of :provider
  validates_length_of :provider, :in => 1..25
  validates_presence_of :uid

  def portal_access?
    return false if deleted?

    corporation ? corporation.portal_access? : false
  end # portal_access

  def management_company?
    corporation ? corporation.manager? : false 
  end # management_company 

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['info']['name']
    end
  end # create_with_omniauth
end
