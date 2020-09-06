# == Schema Information
#
# Table name: electrical_power_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#
require 'test_helper'

class ElectricalPowerDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
