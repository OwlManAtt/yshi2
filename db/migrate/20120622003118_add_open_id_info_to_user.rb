class AddOpenIdInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, :limit => 25
    add_column :users, :uid, :string
  end
end
