# == Schema Information
#
# Table name: humidity_data
#
#  id        :integer          not null, primary key
#  sensor_id :integer
#  value     :float
#  dateTime  :datetime
#

class HumidityDatum < ActiveRecord::Base
  belongs_to :sensor
  
end
