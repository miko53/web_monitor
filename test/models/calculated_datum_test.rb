# == Schema Information
#
# Table name: calculated_data
#
#  id             :integer          not null, primary key
#  value          :float
#  beginPeriod    :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  operation_id   :integer
#  beginPeriodInt :integer
#

require 'test_helper'

class CalculatedDatumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
