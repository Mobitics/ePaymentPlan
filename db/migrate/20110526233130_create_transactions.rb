class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :confirmation_id
      t.boolean :error
      t.string :error_code
      t.string :error_message

      t.timestamps
    end
  end
end
