class AddOrderFields < ActiveRecord::Migration
  def change
    add_column :sensors, :order, :integer
  end
end
