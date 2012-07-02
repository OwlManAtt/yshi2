module Import::CCP
  class InvBlueprintType < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invBlueprintTypes'
    self.primary_key = 'blueprintTypeID'

    belongs_to :inv_type, :foreign_key => 'blueprintTypeID'

    default_scope includes(:inv_type).where({:invTypes => {:published => 1}})

    def etl_map
      {
        :blueprint_type_id => blueprintTypeID,
        :product_type => productTypeID,
        :production_time => productionTime,
        :productivity_modifier => productivityModifier,
        :waste_factor => wasteFactor,
        :production_limit => maxProductionLimit,
        :research_material_time => researchMaterialTime,
        :research_productivity_time => researchProductivityTime,
        :copy_time => researchCopyTime,
      }
    end # etl_map
  end
end
