class CreateDrinks < ActiveRecord::Migration
  def change
    create_table :drinks do |t|
      t.string :drink
      t.integer :cost

      t.timestamps
    end
  end
end
