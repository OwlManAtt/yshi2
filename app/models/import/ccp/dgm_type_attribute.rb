module Import::CCP
  class DgmTypeAttribute < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'dgmTypeAttributes'
    self.primary_key = nil 

    def value
      return valueInt if valueInt
      return valueFloat if valueFloat

      return nil
    end # value
  end
end
