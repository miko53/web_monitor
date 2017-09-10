class RemoveDateTimeInt < ActiveRecord::Migration
  def change
    remove_index :voltage_data, :dateTimeInt
    remove_index :temperature_data, :dateTimeInt
    remove_index :pressure_data, :dateTimeInt
    remove_index :humidity_data, :dateTimeInt
    remove_index :calculated_data, :beginPeriodInt
    
    remove_column  :voltage_data, :dateTimeInt
    remove_column  :temperature_data, :dateTimeInt
    remove_column  :pressure_data, :dateTimeInt
    remove_column  :humidity_data, :dateTimeInt
    remove_column  :calculated_data, :beginPeriodInt
  end
end
