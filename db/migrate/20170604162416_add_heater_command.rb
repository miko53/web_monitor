class AddHeaterCommand < ActiveRecord::Migration[4.2]
  def change
    create_table :range_commands do |t|
      t.string :name
      t.time :start_time
      t.time :stop_time
      t.integer :start_day
      t.integer :stop_day
    end
    
    create_join_table :range_commands, :actuators do |t|
      t.index :range_command_id
      t.index :actuator_id
    end
  end
  
end
