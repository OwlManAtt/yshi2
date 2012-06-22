class User < ActiveRecord::Base
  belongs_to :corporation
  has_many :characters

  attr_accessible :name, :deleted, :corporation

  validates_presence_of :name
  validates_length_of :name, :in => 6..60

  def portal_access?
    return false if deleted?

    corporation ? corporation.portal_access? : false
  end # portal_access

  def management_company?
    corporation ? corporation.manager? : false 
  end # management_company 
end
