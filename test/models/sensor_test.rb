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

require 'test_helper'

class SensorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
