class DropBpTypeFromBlueprints < ActiveRecord::Migration
  def change 
    # This is actually redundant. ID = BP type ID already.
    remove_column :item_blueprints, :blueprint_type_id
  end
end
