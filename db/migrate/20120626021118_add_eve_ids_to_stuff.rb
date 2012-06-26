class AddEveIdsToStuff < ActiveRecord::Migration
  def change
    add_column :characters, :eve_id, :integer
    add_column :corporations, :eve_id, :integer
  end
end
