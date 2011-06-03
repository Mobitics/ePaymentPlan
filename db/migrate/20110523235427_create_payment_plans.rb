class CreatePaymentPlans < ActiveRecord::Migration
  def change
    create_table :payment_plans do |t|
      t.integer :order_id
      t.float :amount
      t.float :shipping
      t.float :tax
      t.float :interest
      t.float :late_fee
      t.boolean :includes_shipping
      t.boolean :includes_tax
      t.integer :payments_count
      t.integer :payment_profile_id

      t.string :notify_url
      t.string :return_url
      t.string :cancel_return_url

      t.timestamps
    end
  end
end
