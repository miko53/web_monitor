class CreateElectricalPowerData < ActiveRecord::Migration
  def change
    create_table :electrical_power_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :date_time
    end
  end
end
