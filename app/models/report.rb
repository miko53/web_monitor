# == Schema Information
#
# Table name: reports
#
#  id              :integer          not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  dateBegin       :string
#  dateEnd         :string
#  isRangeSet      :boolean
#  dayRangeFromEnd :integer
#

class Report < ActiveRecord::Base
  has_many :device_of_reports, :dependent => :destroy
  accepts_nested_attributes_for :device_of_reports, :allow_destroy => true
  
  has_many :operation_of_reports, :dependent => :destroy
  accepts_nested_attributes_for :operation_of_reports, :allow_destroy => true
    
end
