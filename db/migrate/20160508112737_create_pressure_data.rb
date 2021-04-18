class CreatePressureData < ActiveRecord::Migration[4.2]
  def change
    create_table :pressure_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :dateTime

      t.timestamps null: true
    end
  end
end
