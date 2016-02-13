# == Schema Information
#
# Table name: operations
#
#  id           :integer          not null, primary key
#  sensor_id    :integer
#  type         :string
#  currentValue :float
#  period       :integer
#  beginPeriod  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
