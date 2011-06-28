class ChangeColumnsToPlans < ActiveRecord::Migration
  def up
    rename_column :plans, :merchant_id, :store_id
    add_column :plans, :frequency, :string, :default => "monthly" # hourly, daily, weekly, monhtly
  end

  def down
    rename_column :plans, :store_id, :merchant_id
    remove_column :plans, :frequency
  end
end
