class RemoveCharacterApiCharacterId < ActiveRecord::Migration
  def up
    remove_column :characters, :api_character_id
  end

  def down
    add_column :characters, :api_character_id, :integer
  end
end
