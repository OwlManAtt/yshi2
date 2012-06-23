class CreateApiKeys < ActiveRecord::Migration
  def change
    create_table :api_keys do |t|
      t.integer :user_id, :null => false
      t.integer :identifier, :null => false
      t.string :verification_code, :limit => 64, :null => false
      t.integer :access_mask
      t.string :type
      t.date :expires_at
      t.timestamp :last_polled_at
      t.string :last_polled_result
      t.boolean :deleted, :default => false
      t.timestamps
    end

    remove_column :characters, :api_user_id
    remove_column :characters, :api_key

    add_column :characters, :api_key_id, :integer
  end
end
