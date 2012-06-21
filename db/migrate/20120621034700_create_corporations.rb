class CreateCorporations < ActiveRecord::Migration
  def change
    create_table :corporations do |t|
      t.string :name, :limit => 50, :null => false
      t.string :ticker, :limit => 5, :null => false
      t.boolean :deleted, :default => false, :null => false
      t.boolean :portal_access, :default => false, :null => false
      t.boolean :manager, :default => false, :null => false
      t.timestamps
    end
  end
end
