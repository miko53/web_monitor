# == Schema Information
#
# Table name: voltage_data
#
#  id          :integer          not null, primary key
#  sensor_id   :integer
#  value       :float
#  dateTime    :datetime
#  dateTimeInt :integer
#

require 'test_helper'

class VoltageDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
