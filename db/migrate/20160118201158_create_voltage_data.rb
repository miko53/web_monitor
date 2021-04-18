class CreateVoltageData < ActiveRecord::Migration[4.2]
  def change
    create_table :voltage_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :dateTime

      t.timestamps null: false
    end
  end
end
