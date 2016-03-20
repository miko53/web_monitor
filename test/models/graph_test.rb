# == Schema Information
#
# Table name: graphs
#
#  id         :integer          not null, primary key
#  report_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dataset_id :integer
#  title      :string
#

require 'test_helper'

class GraphTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
