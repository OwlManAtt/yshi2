module Import::CCP
  class MapSolarSystem < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'mapSolarSystems'
    self.primary_key = 'solarSystemID'

    def etl_map
      {
        :id => solarSystemID,
        :constellation_id => constellationID,
        :name => solarSystemName,
      }
    end
  end
end
