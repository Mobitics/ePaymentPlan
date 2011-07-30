class AddColumnsToStore < ActiveRecord::Migration
  def change
    add_column :stores, :address_2, :string
  end
end
