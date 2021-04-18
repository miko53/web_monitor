class AddIndex < ActiveRecord::Migration[4.2]
  def change
    add_index :voltage_data, :dateTimeInt, order: { dateTimeInt: :desc }
    add_index :voltage_data, :dateTime, order: { dateTime: :desc }
    
    add_index :temperature_data, :dateTimeInt, order: { dateTimeInt: :desc }
    add_index :temperature_data, :dateTime, order: { dateTime: :desc }
    
    add_index :pressure_data, :dateTimeInt, order: { dateTimeInt: :desc }
    add_index :pressure_data, :dateTime, order: { dateTime: :desc }
    
    add_index :humidity_data, :dateTimeInt, order: { dateTimeInt: :desc }
    add_index :humidity_data, :dateTime, order: { dateTime: :desc }
    
    add_index :calculated_data, :beginPeriodInt, order: { beginPeriodInt: :desc }
    add_index :calculated_data, :beginPeriod, order: { beginPeriod: :desc }
    add_index :calculated_data, :operation_id
  end
end
