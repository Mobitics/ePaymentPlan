class CreateUsers < ActiveRecord::Migration
  def change
    # create_table :users do |t|
    #   t.string :email
    #   t.string :customer_cim_id
    # 
    #   t.timestamps
    # end
    add_column :users, :customer_cim_id, :integer
  end
end
