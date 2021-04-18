class AddOrderFields < ActiveRecord::Migration[4.2]
  def change
    add_column :sensors, :order, :integer
  end
end
