# == Schema Information
#
# Table name: device_of_reports
#
#  id         :integer          not null, primary key
#  deviceName :string
#  flowID     :integer
#  report_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DeviceOfReport < ActiveRecord::Base
  belongs_to :report
  
end
