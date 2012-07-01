module Import::CCP
  class InvGroup < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invGroups'
    self.primary_key = 'groupID'
    
    has_many :inv_types
    belongs_to :inv_category

    default_scope where(:published => 1)

    def etl_map
      {
        :id => groupID,
        :name => groupName,
        :description => description,
        :manufacturable => allowManufacture.to_bn,
        :recyclable => allowRecycler.to_bn,
        :category_id => categoryID,
      }
    end # etl_map
  end
end
