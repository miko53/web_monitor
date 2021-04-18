class AddGraphInReport < ActiveRecord::Migration[4.2]
  def change
    create_table :graphs do |t|
      t.integer :report_id
      t.integer :curve_id
      t.timestamps null: false
    end
    
    create_table :curves do |t|
      t.string :device_name
      t.string :sensor_name
      t.string :operation_name
      t.timestamps null: false
    end
        
    add_index :graphs, :report_id
    add_index :graphs, :curve_id
    
    drop_table :operation_of_reports
    drop_table :device_of_reports    
  end
end
