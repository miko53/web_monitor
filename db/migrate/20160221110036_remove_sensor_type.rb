class RemoveSensorType < ActiveRecord::Migration
  def change
    remove_column  :sensors, :type
    add_column :sensors, :sensor_type, :string
  end
end
