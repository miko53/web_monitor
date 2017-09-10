# == Schema Information
#
# Table name: calculated_data
#
#  id           :integer          not null, primary key
#  value        :float
#  beginPeriod  :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  operation_id :integer
#

class CalculatedDatum < ActiveRecord::Base
    belongs_to :operation
  
end
