# == Schema Information
#
# Table name: temperature_data
#
#  id         :integer          not null, primary key
#  sensor_id  :integer
#  value      :float
#  dateTime   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class TemperatureDatum < ActiveRecord::Base
  belongs_to :sensor
end

