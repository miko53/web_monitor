class AddTemperatureData < ActiveRecord::Migration
  def change
    create_table :temperatureDatas do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :date_time
    end
    add_index :temperatureDatas, :sensor_id
    
    create_table :humidityDatas do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :date_time
    end
    add_index :humidityDatas, :sensor_id

    create_table :voltageDatas do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :date_time
    end
    add_index :voltageDatas, :sensor_id

  end
end
