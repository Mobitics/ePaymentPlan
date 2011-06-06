class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.float :payment
      t.integer :payment_plan_id

      t.timestamps
    end
  end
end
