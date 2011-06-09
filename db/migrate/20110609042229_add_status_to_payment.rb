class AddStatusToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :status, :string, :default => "Pending"
  end
end
