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

require 'test_helper'

class ActuatorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
