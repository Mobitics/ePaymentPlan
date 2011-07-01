class AddColumnDescriptionToPaymentPlans < ActiveRecord::Migration
  def change
    add_column :payment_plans, :description, :string
  end
end
