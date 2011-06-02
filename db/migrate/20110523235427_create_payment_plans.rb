class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.float :interest
      t.float :late_fee
      t.float :payment_value
      t.boolean :includes_shipping
      t.boolean :includes_tax
      t.integer :payments_count
      t.integer :payment_profile_id

      t.timestamps
    end
  end
end
