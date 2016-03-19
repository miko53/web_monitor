class AddNameOnSensorsAndOperations < ActiveRecord::Migration
  def change
    add_column :sensors, :name, :string
    add_column :operations, :name, :string
  end
end
