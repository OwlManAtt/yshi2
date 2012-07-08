module Import::CCP
  class DgmTypeAttribute < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'dgmTypeAttributes'
    self.primary_key = nil 

    belongs_to :attribute_type, :primary_key => :atteibuteID, :foreign_key => :attributeID, :class_name => 'DgmTypeAttribute' 
    delegate :defaultValue, :to => :attribute_type
    
    def value
      return valueInt if valueInt
      return valueFloat if valueFloat

      return defaultValue 
    end # value
  end
end
