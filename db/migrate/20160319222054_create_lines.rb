class CreateLines < ActiveRecord::Migration[4.2]
  def change
    create_table :lines do |t|
      t.string :device_name
      t.string :sensor_name
      t.string :operation_name
      t.integer :graph_id
      t.timestamps null: false
    end
    
    remove_column  :graphs, :curve_id
    add_column :graphs, :line_id, :integer
    add_index :graphs, :line_id
  end
  
  
end
