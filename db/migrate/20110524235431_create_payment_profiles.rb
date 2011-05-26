class CreatePaymentProfiles < ActiveRecord::Migration
  def change
    create_table :payment_profiles do |t|
      t.user_id :integer
      t.payment_cim_id :string

      t.timestamps
    end
  end
end
