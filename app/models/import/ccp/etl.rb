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
      material_list = []

      # Get BP BoM (raw) -- Note that find_each requires a PK to order by, so it's not used here.
      type_table = Import::CCP::InvType.arel_table
      raw_attr = {:type => 'raw', :damage_per_job => 1.0}
      
      # Note that this utilizes a relationship and it is NOT eagerly loaded.
      # Rails chokes to death on #includes() with you have no PK.
      Import::CCP::InvBlueprintMaterial.joins({:inv_blueprint_type => :inv_type}).where(type_table[:published].eq(1)).each do |import|
        mat = Item::BlueprintMaterial.new    
        mat.assign_attributes(import.etl_map.merge(raw_attr), :without_protection => true)
        material_list << mat
      end
      
      # Get BP BoM (component)

      # Save all the materials...
      Item::BlueprintMaterial.import(material_list)

      # Get BP BoM (skill)
    end

    def self.clear_tables
      (IMPORT_TABLES.values + CUSTOM_IMPORT_TABLES).each(&:delete_all)
    end
  end 
end
