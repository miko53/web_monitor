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
#  name           :string
#

class OperationValidator < ActiveModel::Validator
  def validate(record)
    if (record.name != nil && record.name == 'raw') then
      record.errors[:name] << "a operation can't be called 'raw', please change it"
      return
    end
    s = record.sensor
    operations = s.operations
    result = operations.where("name = ?", record.name)
    if (result.count != 0) then
      if (result.count == 1) && (result[0].id == record.id) then
      else
        record.errors[:name] << "an operation has the same name, please change it"
      end
    end
  end
end

class Operation < ActiveRecord::Base
    belongs_to :sensor
    has_many :calculated_data, :dependent => :destroy
    validates_with OperationValidator
    
    def last_sample
      return self.calculated_data.order("beginPeriod DESC")[0]
    end
    
end
