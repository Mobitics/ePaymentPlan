class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.integer :user_id
      t.string :payment_cim_id

      t.timestamps
    end
  end
end
