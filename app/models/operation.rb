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

class Operation < ActiveRecord::Base
    belongs_to :sensor
    has_many :calculated_data, :dependent => :destroy

end
