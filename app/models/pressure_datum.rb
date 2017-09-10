# == Schema Information
#
# Table name: pressure_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#

class PressureDatum < ActiveRecord::Base
  belongs_to :sensor
end
