class CreateDatasets < ActiveRecord::Migration[4.2]
  def change
    create_table :datasets do |t|
      t.string :device_name
      t.string :sensor_name
      t.string :operation_name
      t.integer :graph_id
      t.timestamps null: false
    end
    
    remove_column  :graphs, :line_id
    add_column :graphs, :dataset_id, :integer
    add_index :graphs, :dataset_id
    
    drop_table :lines
    
  end
end
