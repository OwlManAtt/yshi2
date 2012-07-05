module Import::CCP
  class ETL
    IMPORT_TABLES = { 
      Import::CCP::InvCategory => Item::Category,
      Import::CCP::InvGroup => Item::Group,
      Import::CCP::InvType => Item::Type,
      Import::CCP::InvBlueprintType => Item::Blueprint,
    }

    CUSTOM_IMPORT_TABLES = [
      Item::BlueprintMaterial,
      Item::BlueprintSkill,
    ]

    # This will reuse the CCP IDs as PKs.
    def self.process
      self.clear_tables
      self.copy_tables 
      self.flag_bp
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

    def self.flag_bp
      Item::Type.scoped(:joins => :group, :conditions => { :item_groups => {:category_id => 9} }).update_all(:blueprint => true) 
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
