class AddColumnStoreIdToCustomers < ActiveRecord::Migration
  def change
    add_column :customers, :store_id, :integer
  end
end
