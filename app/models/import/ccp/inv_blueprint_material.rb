module Import::CCP
  class InvBlueprintMaterial < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invTypeMaterials'
    self.primary_key = nil 
    
    belongs_to :inv_blueprint_type, :primary_key => :productTypeID, :foreign_key => :typeID
    delegate :blueprintTypeID, :to => :inv_blueprint_type, :allow_nil => true
    
    def etl_map
      {
        :blueprint_type_id => blueprintTypeID, 
        :material_type_id => materialTypeID,
        :quantity => quantity,
        :damage_per_job => nil,
        :type => nil,
      }
    end # etl_map
  end
end

