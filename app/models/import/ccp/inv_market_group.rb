module Import::CCP
  class InvMarketGroup < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invMarketGroups'
    self.primary_key = 'marketGroupID' 

    def etl_map
      {
        :id => marketGroupID,
        :parent_id => parentGroupID,
        :name => marketGroupName,
        :description => description,
      }
    end
  end
end
