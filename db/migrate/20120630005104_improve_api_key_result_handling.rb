class ImproveApiKeyResultHandling < ActiveRecord::Migration
  def change 
    remove_column :api_keys, :last_polled_result
    add_column :api_keys, :last_polled_result_code, :integer
    add_column :api_keys, :last_polled_result_message, :string, :limit => 255
    add_column :api_keys, :permanent_failure, :boolean, :null => false, :default => false
  end
end
