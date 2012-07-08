module Import::CCP
  class MapRegion < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'mapRegions'
    self.primary_key = 'regionID'

    def etl_map
      {
        :id => regionID,
        :name => regionName,
      }
    end
  end
end
