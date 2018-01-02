# == Schema Information
#
# Table name: actuators
#
#  id              :integer          not null, primary key
#  name            :string
#  device_id       :integer
#  actuator_type   :string
#  order           :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  value           :string
#  refreshDateTime :datetime
#  forced          :boolean
#

class ActuatorValidator < ActiveModel::Validator
  def validate(record)    
    device = Device.find(record.device_id)
    actuators = device.actuators
    result = actuators.where("name = ?", record.name)
    if (result.count != 0) then
      if (result.count == 1) && (result[0].id == record.id) then
      else
      record.errors[:name] << "a actuator has the same name, please change it"
      end
    end
  end
end

class Actuator < ActiveRecord::Base
  has_and_belongs_to_many :range_commands 
  belongs_to :device
  include ActiveModel::Validations
  validates_with ActuatorValidator

  @@heater_actions_list = %w[CONFORT CONFORT_M1 CONFORT_M2 ECO HG STOP]
  
  def self.heater_actions_list
    @@heater_actions_list
  end
  
end
