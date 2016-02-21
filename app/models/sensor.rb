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
#

class Sensor < ActiveRecord::Base
  belongs_to :device
  has_many :operations, :dependent => :destroy

  def insert_sample(value)
    case (sensor_type)
      when "Temperature"
        insert_temperature_sample(value)
      when "Humidity"
        insert_humidity_sample(value)
      when "Voltage"
        insert_voltage_sample(value)
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
  
private
  
  def insert_temperature_sample(value)
    t = TemperatureDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end

  def insert_humidity_sample(value)
    t = HumidityDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end

  def insert_voltage_sample(value)
    t = VoltageDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end
end
