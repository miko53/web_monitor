# == Schema Information
#
# Table name: pressure_data
#
#  id          :integer          not null, primary key
#  sensor_id   :integer
#  value       :float
#  dateTime    :datetime
#  dateTimeInt :integer
#

require 'test_helper'

class PressureDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
