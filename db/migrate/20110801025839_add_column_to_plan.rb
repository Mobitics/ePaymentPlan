class AddColumnToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :first_payment_rate, :float, :default => 0
  end
end
