module Import::CCP
  class InvCategory < ActiveRecord::Base
    establish_connection :ccp_export

    self.table_name = 'invCategories'
    self.primary_key = 'categoryID'

    has_many :inv_groups

    default_scope where(:published => 1)

    def etl_map
      {
        :id => categoryID,
        :name => categoryName,
        :description => description,
      }
    end # etl_map
  end
end
