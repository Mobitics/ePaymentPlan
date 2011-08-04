class AddColumnPlanIdToPaymentPlan < ActiveRecord::Migration
  def change
    add_column :payment_plans, :plan_id, :integer
  end
end
