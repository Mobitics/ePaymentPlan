class AddColumnToStore < ActiveRecord::Migration
  def change
    add_column :stores, :first_step, :boolean, :default => false
  end
end
