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
#

class Actuator < ActiveRecord::Base
  belongs_to :device
  
end
