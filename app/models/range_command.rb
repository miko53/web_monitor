# == Schema Information
#
# Table name: range_commands
#
#  id         :integer          not null, primary key
#  name       :string
#  start_time :time
#  stop_time  :time
#  start_day  :integer
#  stop_day   :integer
#

class RangeCommand < ActiveRecord::Base
   has_and_belongs_to_many :actuators
end
