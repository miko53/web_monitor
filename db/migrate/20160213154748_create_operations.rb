class CreateOperations < ActiveRecord::Migration
  def change
    create_table :operations do |t|
      t.integer :sensor_id
      t.string :type
      t.float :currentValue
      t.integer :period
      t.datetime :beginPeriod

      t.timestamps null: false
    end
  end
end
