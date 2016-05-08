module ReportsHelper
  
  def self.unit(typeName)
    unit = "-"
    case (typeName)
      when "Temperature"
        unit = "°C"
      when "Humidity"
        unit = "°H"
      when "Voltage"
        unit = "V"
      when "Pressure"
        unit = "hPa"
      else
    end
  end
end
