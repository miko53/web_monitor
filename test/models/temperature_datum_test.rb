# == Schema Information
#
# Table name: temperature_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#

require 'test_helper'

class TemperatureDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
