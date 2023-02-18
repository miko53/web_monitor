# == Schema Information
#
# Table name: sensors
#
#  id          :integer          not null, primary key
#  device_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  order       :integer
#  sensor_type :string
#  name        :string
#

class SensorValidator < ActiveModel::Validator
  def validate(record)    
    device = Device.find(record.device_id)
    sensors = device.sensors
    result = sensors.where("name = ?", record.name)
    if (result.count != 0) then
      if (result.count == 1) && (result[0].id == record.id) then
      else
      record.errors[:name] << "a sensor has the same name, please change it"
      end
    end
  end
end
 
class Sensor < ActiveRecord::Base
  belongs_to :device
  has_many :operations, :dependent => :destroy
  include ActiveModel::Validations
  validates_with SensorValidator
  
  def insert_sample(value)
    case (sensor_type)
      when "Temperature"
        insert_temperature_sample(value)
      when "Humidity"
        insert_humidity_sample(value)
      when "Voltage"
        insert_voltage_sample(value)
      when "Pressure"
        insert_pressure_sample(value)
      when "ElectricalMeter"
        insert_electric_sample(value)
      when "ElectricalConsumption"
        insert_electric_consumption_sample(value)
      when "WindDirection"
        insert_wind_dir_sample(value)
      when "WindSpeed"
        insert_wind_speed_sample(value)
      when "RainFall"
        insert_rain_fall_sample(value)
      else
        raise "DB doesn't exist"
    end
  end

  def db
    case (sensor_type)
      when "Temperature"
        return TemperatureDatum
      when "Humidity"
        return HumidityDatum
      when "Voltage"
        return VoltageDatum
      when "Pressure"
        return PressureDatum
      when "ElectricalMeter"
        return ElectricalPowerDatum
      when "ElectricalConsumption"
        return ElectricalConsumptionDatum
      when "WindDirection"
        return WindDirection
      when "WindSpeed"
        return WindSpeed
      when "RainFall"
        return RainFall
      else
        raise "DB unknown"
    end
  end
  
  def remove_samples
    samples = db.where(sensor_id: id)
    samples.each do |s|
      s.destroy
    end
  end
  
  def last_sample
    return db.where(sensor_id: id).order("dateTime DESC").limit(1)[0]
  end
  
  def find_sample(sample_id)
    return db.where(sensor_id: id, id: sample_id)
  end
  
private
  
  def insert_temperature_sample(value)
    date = DateTime.now
    t = TemperatureDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save
  end

  def insert_humidity_sample(value)
    date = DateTime.now
    t = HumidityDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save
  end

  def insert_voltage_sample(value)
    date = DateTime.now
    t = VoltageDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save
  end
  
  def insert_pressure_sample(value)
    date = DateTime.now
    t = PressureDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save
  end
  
  def insert_wind_dir_sample(value)
    date = DateTime.now
    t = WindDirection.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save    
  end
  
  def insert_wind_speed_sample(value)
    date = DateTime.now
    t = WindSpeed.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save    
  end
  
  def insert_rain_fall_sample(value)
    date = DateTime.now
    t = RainFall.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = date
    t.save    
  end
  
  def insert_electric_sample(value)
    #TODO
  end
  
  def insert_electric_consumption_sample(value)
    #TODO
  end
end
