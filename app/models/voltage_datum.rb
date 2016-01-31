# == Schema Information
#
# Table name: voltage_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#

class VoltageDatum < ActiveRecord::Base
  belongs_to :sensor
end
