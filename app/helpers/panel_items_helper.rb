module PanelItemsHelper
  
  def sensor_value(sensor_name, sensor_operation)
    
    v = nil
    s = Sensor.find_by_name(sensor_name)
    
    if (s != nil) then
      if (sensor_operation == "raw") then
        data = s.db.where('sensor_id=?', s.id).order('dateTime ASC').last
        if (data != nil) then
          v = data.value.to_s + getUnit(s)
        end
      else  
        operation = s.operations.find_by_name(sensor_operation)
        if (operation != nil) then
          data = CalculatedDatum.where('operation_id=?', operation.id).order('beginPeriod ASC').last
          if (data != nil) then
            v = data.value.to_s + getUnit(s)
          end
        end
      end
    end
    
    return v
  end
  
  def sensor_refresh_date(sensor_name, sensor_operation)
    
    v = nil
    s = Sensor.find_by_name(sensor_name)
    
    if (s != nil) then
      if (sensor_operation == "raw") then
        data = s.db.where('sensor_id=?', s.id).order('dateTime ASC').last
        if (data != nil) then
          v = data.dateTime
        end
      else  
        operation = s.operations.find_by_name(sensor_operation)
        if (operation != nil) then
          data = CalculatedDatum.where('operation_id=?', operation.id).order('beginPeriod ASC').last
          if (data != nil) then
            v = data.beginPeriod
          end
        end
      end
    end
    
    return v
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
