class AddAccountAndNumColumnToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :account, :string
    add_column :orders, :num, :string
  end
end
