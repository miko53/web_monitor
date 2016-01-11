class CreateSensors < ActiveRecord::Migration
  def change
    create_table :sensors do |t|
      t.integer :device_id
      t.string :type

      t.timestamps null: false
    end
    
    add_index :sensors, :device_id
    
  end
end
