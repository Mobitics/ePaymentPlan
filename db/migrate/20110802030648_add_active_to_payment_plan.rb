class AddActiveToPaymentPlan < ActiveRecord::Migration
  def change
    add_column :payment_plans, :active, :boolean,:default=>true
  end
end
