class AddColumnsToPaymentProfiles < ActiveRecord::Migration
  def change
    add_column :payment_profiles, :customer_id, :integer
  end
end
