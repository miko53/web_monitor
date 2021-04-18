class RemoveSensorType < ActiveRecord::Migration[4.2]
  def change
    remove_column  :sensors, :type
    add_column :sensors, :sensor_type, :string
  end
end
