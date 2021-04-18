class CreateActuators < ActiveRecord::Migration[4.2]
  def change
    create_table :actuators do |t|
      t.string :name
      t.integer :device_id
      t.string :actuator_type
      t.integer :order

      t.timestamps null: false
    end

    add_index :actuators, :device_id
    
  end
end
