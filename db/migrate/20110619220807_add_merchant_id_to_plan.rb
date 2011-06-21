class AddMerchantIdToPlan < ActiveRecord::Migration
  def change
    add_column :plans, :merchant_id, :integer
  end
end
