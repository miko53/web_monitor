class RemoveDateTimeUpdate < ActiveRecord::Migration[4.2]
  def change
    remove_column  :temperature_data, :created_at 
    remove_column  :temperature_data, :updated_at
    remove_column  :humidity_data, :created_at 
    remove_column  :humidity_data, :updated_at
    remove_column  :voltage_data, :created_at 
    remove_column  :voltage_data, :updated_at
  end
end
