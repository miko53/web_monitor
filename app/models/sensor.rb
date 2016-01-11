# == Schema Information
#
# Table name: sensors
#
#  id         :integer          not null, primary key
#  device_id  :integer
#  type       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Sensor < ActiveRecord::Base
  belongs_to :device
  TYPES = %w( Temperature Humidity Voltage)
  before_save :set_type
  
  def set_type
    raise "Type is not defined"
  end
  
end

class Temperature < Sensor
  def set_type
    self.type = "Temperature"
  end
end

class Humidity < Sensor
  def set_type
    self.type = "Humidity"
  end
end

class Voltage < Sensor
  def set_type
    self.type = "Voltage"
  end
end
