class AddPaymenProfileIdToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payment_profile_id, :integer
  end
end
