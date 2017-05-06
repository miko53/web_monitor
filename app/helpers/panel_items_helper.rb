module PanelItemsHelper
  
  def sensor_value(sensor_name, sensor_operation)
    v = nil
    r = nil
    s = Sensor.find_by_name(sensor_name)
    
    if (s != nil) then
      if (sensor_operation == "raw") then
        data = s.db.where('sensor_id=?', s.id).order('dateTimeInt DESC').first
        if (data != nil) then
          v = data.value.to_s + getUnit(s)
          r = data.dateTime
        end
      else  
        operation = s.operations.find_by_name(sensor_operation)
        if (operation != nil) then
          data = CalculatedDatum.where('operation_id=?', operation.id).order('beginPeriod DESC').first
          if (data != nil) then
            v = data.value.to_s + getUnit(s)
            r = data.beginPeriod
          end
        end
      end
    end
    
    return v,r 
  end

private
  def getUnit(sensor)
    s = ""
    case sensor.sensor_type
     when "Temperature"
        s = " °C"
     when "Humidity"
        s = " °"
     when "Voltage"
        s = " V"
     when "Pressure"
        s = " hPa"
    end
    return s
  end

end
