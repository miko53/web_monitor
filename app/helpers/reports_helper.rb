module ReportsHelper
  
  def unit(typeName)
    unit = "-"
    case (typeName)
      when "Temperature"
        unit = "°C"
      when "Humidity"
        unit = "°H"
      when "Voltage"
        unit = "V"
      else
    end
  end
end
