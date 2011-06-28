class CreateAuthorizeNets < ActiveRecord::Migration
  def change
    create_table :authorize_nets do |t|
      t.string :api_login_id
      t.string :transaction_key
      t.boolean :test_mode, :default => false
      t.integer :store_id

      t.timestamps
    end
  end
end
