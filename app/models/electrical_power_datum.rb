# == Schema Information
#
# Table name: electrical_power_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#
class ElectricalPowerDatum < ActiveRecord::Base
  belongs_to :sensor
end
