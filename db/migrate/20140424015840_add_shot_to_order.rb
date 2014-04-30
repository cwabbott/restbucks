class AddShotToOrder < ActiveRecord::Migration
  def change
    add_column :orders, :additions, :string
  end
end
