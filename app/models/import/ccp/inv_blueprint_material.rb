module Import::CCP
  class InvBlueprintMaterial < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invTypeMaterials'
    self.primary_key = nil 
    
    belongs_to :inv_blueprint_type, :primary_key => :productTypeID, :foreign_key => :typeID
    delegate :blueprintTypeID, :to => :inv_blueprint_type, :allow_nil => true
  
    scope :raw, joins({:inv_blueprint_type => :inv_type}).where(InvType.arel_table[:published].eq(1))
    
    def etl_map
      {
        :blueprint_type_id => blueprintTypeID, 
        :material_type_id => materialTypeID,
        :quantity => quantity,
        :damage_per_job => 1.0,
        :type => 'raw',
      }
    end # etl_map
  end
end

