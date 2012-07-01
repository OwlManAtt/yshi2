module Import::CCP
  class ETL
    IMPORT_TABLES = { 
      Import::CCP::InvCategory => Item::Category,
      Import::CCP::InvGroup => Item::Group,
      Import::CCP::InvType => Item::Type,
    }

    # This will reuse the CCP IDs as PKs.
    def self.process(reset = true)
      self.clear_tables if reset
  
      IMPORT_TABLES.each do |source, dest|
        source.find_each do |import|
          obj = dest.new
          obj.assign_attributes(import.etl_map, :without_protection => true)
          obj.save
        end
      end
      
      # Get BP details
      # Get BP BoM (raw)
      # Get BP BoM (component)
      # Get BP BoM (skill)

    end

    protected
    def self.clear_tables
      IMPORT_TABLES.values.each(&:delete_all)
    end
  end 
end
