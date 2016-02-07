# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dateBegin       :string
#  dateEnd         :string
#  isRangeSet      :boolean
#  dayRangeFromEnd :integer
#

require 'test_helper'

class ReportTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
