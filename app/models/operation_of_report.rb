# == Schema Information
#
# Table name: operation_of_reports
#
#  id          :integer          not null, primary key
#  deviceName  :string
#  operationID :integer
#  report_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class OperationOfReport < ActiveRecord::Base
  belongs_to :report

end
