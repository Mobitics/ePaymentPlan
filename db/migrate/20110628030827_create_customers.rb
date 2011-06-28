class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :email
      t.integer :customer_cim_id

      t.timestamps
    end
  end
end
