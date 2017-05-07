class AddDateTimeStamp < ActiveRecord::Migration
  def change

    add_column  :temperature_data, :dateTimeInt, :integer
    add_column  :humidity_data, :dateTimeInt, :integer
    add_column  :pressure_data, :dateTimeInt, :integer
    add_column  :voltage_data, :dateTimeInt, :integer
    add_column  :calculated_data, :beginPeriodInt, :integer
        
    ActiveRecord::Base.transaction do
      TemperatureDatum.all.each do |t| 
      t.dateTimeInt = t.dateTime.to_i
      t.save
      end
      
      HumidityDatum.all.each do |t| 
      t.dateTimeInt = t.dateTime.to_i
      t.save
      end

      VoltageDatum.all.each do |t| 
      t.dateTimeInt = t.dateTime.to_i
      t.save
      end

      PressureDatum.all.each do |t|
      t.dateTimeInt = t.dateTime.to_i
      t.save
      end

      CalculatedDatum.all.each do |t|
      t.beginPeriodInt = t.beginPeriod.to_i
      t.save
      end
    end
    
  end
end
