class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name, :limit => 60, :null => false
      t.boolean :deleted, :default => false, :null => false
      t.integer :corporation_id, :default => nil
      t.timestamps
    end
  end
end
