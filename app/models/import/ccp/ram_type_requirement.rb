module Import::CCP
  class RamTypeRequirement < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'ramTypeRequirements'
    self.primary_key = nil 

    belongs_to :inv_type, :primary_key => :typeID, :foreign_key => :requiredTypeID

    scope :manufacturing, joins({:inv_type => :inv_group}).where(InvType.arel_table[:published].eq(1)).where(self.arel_table[:activityID].eq(1))

    { :components => InvGroup.arel_table[:categoryID].not_eq(16), 
      :skills => InvGroup.arel_table[:categoryID].eq(16),
    }.each { |scope_name, condition| scope scope_name, manufacturing.where(condition) } 

    def etl_map(scope = :generic)
      map = {
        :blueprint_type_id => typeID,
        :material_type_id => requiredTypeID,
        :quantity => quantity,
        :damage_per_job => damagePerJob,
        :type => 'component',
      }
      
      if scope == :skills
        map.except!(:damage_per_job, :type)
        map[:minimum_level] = map.delete(:quantity)
      end

      return map
    end
  end
end
