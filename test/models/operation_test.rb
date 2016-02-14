# == Schema Information
#
# Table name: operations
#
#  id           :integer          not null, primary key
#  sensor_id    :integer
#  currentValue :float
#  period       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  calcul_type  :string
#  beginPeriod  :time
#

require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
