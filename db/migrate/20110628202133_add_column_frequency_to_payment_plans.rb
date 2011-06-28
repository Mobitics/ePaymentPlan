class AddColumnFrequencyToPaymentPlans < ActiveRecord::Migration
  def change
    add_column :payment_plans, :frequency, :string, :default => "monthly" # hourly, daily, weekly, monhtly
  end
end
