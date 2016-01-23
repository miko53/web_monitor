# == Schema Information
#
# Table name: sensors
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  order      :integer
#

class Sensor < ActiveRecord::Base
  belongs_to :device
  TYPES = %w( Temperature Humidity Voltage)
  before_save :set_type
  
  def set_type
    raise "Type is not defined"
  end

  def insert_sample(value)
    raise "DB doesn't exist"
  end

  def db
    raise "DB to set"
  end
end

class Temperature < Sensor
  def set_type
    self.type = "Temperature"
  end
  
  def insert_sample(value)
    t = TemperatureDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end
  
  def db
    return TemperatureDatum
  end  
end

class Humidity < Sensor
  def set_type
    self.type = "Humidity"
  end
  
  def insert_sample(value)
    t = HumidityDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end
  
  def db
    return HumidityDatum
  end
  
end

class Voltage < Sensor
  def set_type
    self.type = "Voltage"
  end

  def insert_sample(value)
    t = VoltageDatum.new
    t.value = value 
    t.sensor_id = id
    t.dateTime = DateTime.now
    t.save
  end

  def db
    return VoltageDatum
  end
end
