class AddFieldsToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :payment_id, :integer
    add_column :transactions, :auth_code, :string
  end
end
