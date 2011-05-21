class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :amount
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :country
      t.string :city
      t.string :address1
      t.string :address2
      t.string :state
      t.string :zip
      t.float :shipping
      t.float :tax
      t.string :notify_url
      t.string :return_url
      t.string :cancel_return_url

      t.timestamps
    end
  end
end
