# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow     :boolean
#

require 'test_helper'

class DeviceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
