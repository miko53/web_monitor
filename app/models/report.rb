
class Report
#  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  def persisted?
    return false
  end
 
  def initialize(attributes = {})
    attributes.each do |name, value|
      send("#{name}=", value)
    end
  end
  
  attr_accessor :title, :deviceName, :flowID, :dateBegin, :dateEnd

end
