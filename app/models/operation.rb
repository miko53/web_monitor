# == Schema Information
#
# Table name: operations
#
#  id             :integer          not null, primary key
#  sensor_id      :integer
#  currentValue   :float
#  period         :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  calcul_type    :string
#  endPeriod      :datetime
#  number_samples :integer
#  period_unit    :integer
#

class Operation < ActiveRecord::Base
    belongs_to :sensor
    has_many :calculated_data, :dependent => :destroy

    def last_sample
      return self.calculated_data.order("beginPeriod DESC")[0]
    end
    
end
