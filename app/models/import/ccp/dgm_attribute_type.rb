module Import::CCP
  class DgmAttributeType < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'dgmAttributeTypes'
    self.primary_key = 'attributeID'

    has_many :attributes, :foreign_key => :attributeID, :class_name => 'DgmTypeAttribute'

    # These aren't scopes because #first cannot be used with a scope (since it executes)
    def self.meta_level
      where(:attributeID => 633).first
    end

    def self.tech_level
      where(:attributeID => 422).first
    end
  end
end
