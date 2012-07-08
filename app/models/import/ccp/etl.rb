module Import::CCP
  class ETL
    IMPORT_TABLES = { 
      Import::CCP::InvCategory => Item::Category,
      Import::CCP::InvGroup => Item::Group,
      Import::CCP::InvType => Item::Type,
      Import::CCP::InvBlueprintType => Item::Blueprint,
      Import::CCP::InvMarketGroup => Item::MarketGroup,
      Import::CCP::MapRegion => Map::Region,
      Import::CCP::MapConstellation => Map::Constellation,
      Import::CCP::MapSolarSystem => Map::SolarSystem,
      Import::CCP::StaStation => Map::Station,
    }

    CUSTOM_IMPORT_TABLES = [
      Item::BlueprintMaterial,
      Item::BlueprintSkill,
    ]

    # This will reuse the CCP IDs as PKs.
    def self.process
      self.clear_tables
      self.copy_tables 
      self.set_item_attributes
      self.copy_bill_of_materials
    end

    protected
    def self.copy_tables
      IMPORT_TABLES.each do |source, dest|
        list = []

        source.find_each do |import|
          obj = dest.new
          obj.assign_attributes(import.etl_map, :without_protection => true)
          list << obj
        end

        dest.import(list)
      end
    end

    def self.set_item_attributes
      Item::Type.scoped(:joins => :group, :conditions => { :item_groups => {:category_id => 9} }).update_all(:blueprint => true) 

      {
        :meta_level => :metalevel,
        :tech_level => :techlevel, 
      }.each do |scope, attr_name|
        # Summarize the data so we only need to do a few updates instead of one per
        # item type.
        lookup = {} 
        attr = Import::CCP::DgmAttributeType.send(scope)

        attr.attributes.each do |import|
          lookup[import.value] = [] unless lookup.has_key? import.value
          lookup[import.value] << import.typeID
        end

        lookup.each do |attr_value, items|
          Item::Type.where(:id => items).update_all(attr_name => attr_value)
        end

        # And then handle the defaults when no attribute is specified.
        Item::Type.where(attr_name => nil).update_all(attr_name => attr.defaultValue)
      end # attributes
    end

    def self.copy_bill_of_materials

      # Get BP BoM, raw & component.
      #
      # Note that the lack of PK in these tables seriously inhibits
      # Rails' magic mojo. #find_each() and eager loading are both unusable here because
      # of all the goddamn opinions hardcoded everywhere in the framework.
      material_list = []

      [
        Proc.new { Import::CCP::InvBlueprintMaterial.raw }, 
        Proc.new { Import::CCP::RamTypeRequirement.components },
      ].each do |scope|
        material_list += scope.call.map do |import|
          mat = Item::BlueprintMaterial.new
          mat.assign_attributes(import.etl_map, :without_protection => true)

          mat
        end
      end

      # Bulk INSERT them. 
      puts material_list.inspect
      Item::BlueprintMaterial.import(material_list)

      # Get BP BoM (skill)
      skill_list = Import::CCP::RamTypeRequirement.skills.map do |import|
        mat = Item::BlueprintSkill.new
        mat.assign_attributes(import.etl_map(:skills), :without_protection => true)

        mat
      end

      Item::BlueprintSkill.import(skill_list)
    end

    def self.clear_tables
      (IMPORT_TABLES.values + CUSTOM_IMPORT_TABLES).each(&:delete_all)
    end
  end 
end
