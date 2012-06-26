class CorporationTickerNotRequired < ActiveRecord::Migration
  def up
    change_column :corporations, :ticker, :string, :limit => 5, :null => true 
  end

  def down
    change_column :corporations, :ticker, :string, :limit => 5, :null => false 
  end
end
