class AddNameOnSensorsAndOperations < ActiveRecord::Migration[4.2]
  def change
    add_column :sensors, :name, :string
    add_column :operations, :name, :string
  end
end
