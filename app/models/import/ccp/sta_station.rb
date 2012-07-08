module Import::CCP
  class StaStation < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'staStations'
    self.primary_key = 'stationID'

    def etl_map
      {
        :id => stationID,
        :solar_system_id => solarSystemID,
        :name => stationName,
      }
    end
  end
end
