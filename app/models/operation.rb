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

class Operation < ActiveRecord::Base
    belongs_to :sensor
    has_many :calculated_data, :dependent => :destroy

end
