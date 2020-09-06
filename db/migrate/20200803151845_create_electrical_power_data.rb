class CreateElectricalPowerData < ActiveRecord::Migration[6.0]
  def change
    create_table :electrical_power_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :date_time
    end
  end
end
