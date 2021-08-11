# == Schema Information
#
# Table name: electrical_consumption_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#
class ElectricalConsumptionDatum < ActiveRecord::Base
  belongs_to :sensor
end
