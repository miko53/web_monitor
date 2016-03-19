# == Schema Information
#
# Table name: operations
#
#  id             :integer          not null, primary key
#  sensor_id      :integer
#  currentValue   :float
#  period         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  calcul_type    :string
#  endPeriod      :datetime
#  number_samples :integer
#  period_unit    :integer
#  name           :string
#

require 'test_helper'

class OperationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
