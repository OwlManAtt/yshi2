module Import::CCP
  class MapConstellation < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'mapConstellations'
    self.primary_key = 'constellationID'

    def etl_map
      {
        :id => constellationID,
        :region_id => regionID,
        :name => constellationName,
      }
    end
  end
end
