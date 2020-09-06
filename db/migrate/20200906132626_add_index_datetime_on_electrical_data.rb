class AddIndexDatetimeOnElectricalData < ActiveRecord::Migration
  def change
    
    add_index :electrical_power_data, :dateTime, order: { dateTime: :desc }
    add_index :electrical_consumption_data, :dateTime, order: { dateTime: :desc }
    
  end
end
