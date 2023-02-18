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
      when "ElectricalMeter"
        unit = "Watt"
      when "ElectricalConsumption"
        unit = "Wh"
      when "WindDirection"
        unit = "°"
      when "WindSpeed"
        unit = "m/s"
      when "RainFall"
        unit = "mm"
    else
    end
  end
end
