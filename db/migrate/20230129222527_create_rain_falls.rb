class CreateRainFalls < ActiveRecord::Migration[6.1]
  def change
    create_table :rain_falls do |t|
      t.integer :sensor_id
      t.float :value
      t.datetime :dateTime

      t.timestamps null: true
    end
  end
end
