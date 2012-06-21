class CreateCharacters < ActiveRecord::Migration
  def change
    create_table :characters do |t|
      t.string :name, :limit => 24, :null => false
      t.integer :user_id, :default => nil
      t.integer :corporation_id, :default => nil
      t.integer :api_user_id, :default => nil
      t.integer :api_character_id, :default => nil
      t.string :api_key, :limit => 64, :default => nil
      t.boolean :director, :default => false, :null => false
      t.boolean :deleted, :default => false, :null => false
      t.timestamps
    end
  end
end
