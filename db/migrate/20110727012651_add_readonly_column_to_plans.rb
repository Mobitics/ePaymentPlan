class AddReadonlyColumnToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :is_readonly, :boolean, :default => false
  end
end
