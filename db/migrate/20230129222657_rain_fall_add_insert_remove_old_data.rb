class RainFallAddInsertRemoveOldData < ActiveRecord::Migration[6.1]
  def change
    add_index :rain_falls, :dateTime, order: { dateTime: :desc }
    remove_column  :rain_falls, :created_at 
    remove_column  :rain_falls, :updated_at    
  end
end
