class WindSpeedsAddInsertRemoveOldData < ActiveRecord::Migration[6.1]
  def change
    add_index :wind_speeds, :dateTime, order: { dateTime: :desc }
    remove_column  :wind_speeds, :created_at 
    remove_column  :wind_speeds, :updated_at    
  end
end
