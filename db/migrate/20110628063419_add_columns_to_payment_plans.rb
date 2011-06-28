class AddColumnsToPaymentPlans < ActiveRecord::Migration
  def change
    add_column :payment_plans, :store_id, :integer
  end
end
