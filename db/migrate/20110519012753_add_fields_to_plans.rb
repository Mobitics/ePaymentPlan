class AddFieldsToPlans < ActiveRecord::Migration
  def change
    add_column :plans, :payments_count, :string
    add_column :plans, :includes_shipping, :boolean
    add_column :plans, :includes_tax, :boolean
    add_column :plans, :interest, :string
    add_column :plans, :late_fee, :string
    add_column :plans, :plan_type, :string
    add_column :plans, :min_price, :string
    add_column :plans, :max_price, :string
    add_column :plans, :product_id, :integer
  end
end
