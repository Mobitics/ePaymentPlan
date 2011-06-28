class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :zip
      t.string :state
      t.string :country
      t.integer :user_id

      t.timestamps
    end
    add_index :stores, :name, :unique => true
  end
end
