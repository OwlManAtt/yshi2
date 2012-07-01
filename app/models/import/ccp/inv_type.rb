module Import::CCP
  class InvType < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invTypes'
    self.primary_key = 'typeID'
    
    belongs_to :inv_group

    default_scope where(:published => 1)

    def etl_map
      {
        :id => typeID, 
        :name => typeName, 
        :description => description, 
        :radius => radius, 
        :mass => mass,
        :volume => volume,
        :capacity => capacity,
        :units_per_run => portionSize,
        :npc_price => basePrice,
        :item_type_group_id => groupID,
      }
    end # etl_map
  end
end
