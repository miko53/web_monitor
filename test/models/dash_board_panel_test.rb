# == Schema Information
#
# Table name: dash_board_panels
#
#  id            :integer          not null, primary key
#  dash_board_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string
#

require 'test_helper'

class DashBoardPanelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
