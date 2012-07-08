class CreateMapTables < ActiveRecord::Migration
  def change
    create_table :map_regions do |t|
      t.string :name, :limit => 100, :null => false
    end 
    
    create_table :map_constellations do |t|
      t.integer :region_id, :null => false
      t.string :name, :limit => 100, :null => false
    end

    create_table :map_solar_systems do |t|
      t.integer :constellation_id, :null => false
      t.string :name, :limit => 100, :null => false
    end

    create_table :map_stations do |t|
      t.integer :solar_system_id, :null => false
      t.string :name, :limit => 100, :null => false
    end
  end
end
