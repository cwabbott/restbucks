class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :cardNo
      t.date :expires
      t.string :name
      t.integer :amount

      t.timestamps
    end
  end
end
