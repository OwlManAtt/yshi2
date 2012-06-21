class User < ActiveRecord::Base
  belongs_to :corporation
  has_many :characters

  def portal_access?
    return false if deleted?

    corporation ? corporation.portal_access? : false
  end # portal_access

  def management_company?
    corporation ? corporation.manager? : false 
  end # management_company 
end
