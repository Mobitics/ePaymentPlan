class AddColumnToPaymentPlan < ActiveRecord::Migration
  def change
    add_column :payment_plans, :first_payment_rate, :float,:default=>0
  end
end
