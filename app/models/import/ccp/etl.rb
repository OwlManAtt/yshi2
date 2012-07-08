module Import::CCP
  class ETL
    IMPORT_TABLES = { 
      Import::CCP::InvCategory => Item::Category,
      Import::CCP::InvGroup => Item::Group,
      Import::CCP::InvType => Item::Type,
      Import::CCP::InvBlueprintType => Item::Blueprint,
      Import::CCP::InvMarketGroup => Item::MarketGroup,
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

      # Summarize all of the item -> metalevels into metaleval -> [item list]. This way,
      # we end up with 17 UPDATE statements to run instead of Item::Type.size UPDATEs.
      metalevels = {} 
      Import::CCP::DgmTypeAttribute.where(:attributeID => 633).each do |import|
        unless metalevels.has_key? import.value
          metalevels[import.value] = []
        end

        metalevels[import.value] << import.typeID
      end

      metalevels.each do |metalevel, items|
        Item::Type.where(:id => items).update_all(:metalevel => metalevel)
      end
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
