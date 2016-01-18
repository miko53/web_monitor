# == Schema Information
#
# Table name: voltage_data
#
#  id         :integer          not null, primary key
#  sensor_id  :integer
#  value      :float
#  dateTime   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class VoltageDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
