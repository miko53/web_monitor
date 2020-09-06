class CreateElectricalConsumptionData < ActiveRecord::Migration[6.0]
  def change
    create_table :electrical_consumption_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :dateTime
    end
  end
end
