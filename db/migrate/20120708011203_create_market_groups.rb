class CreateMarketGroups < ActiveRecord::Migration
  def change 
    create_table :item_market_groups do |t|
      t.integer :parent_id
      t.string :name, :limit => 50, :null => false
      t.text :description
    end    
  end
end
