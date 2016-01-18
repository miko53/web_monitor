class CreateHumidityData < ActiveRecord::Migration
  def change
    create_table :humidity_data do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :dateTime

      t.timestamps null: false
    end
  end
end
