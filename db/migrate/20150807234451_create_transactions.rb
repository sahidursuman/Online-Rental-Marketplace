class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.references :reservation, index: true
      t.decimal :amount
      t.string :type

      t.timestamps null: false
    end
    add_foreign_key :transactions, :reservations
  end
end
