# == Schema Information
#
# Table name: datasets
#
#  id             :integer          not null, primary key
#  device_name    :string
#  sensor_name    :string
#  operation_name :string
#  graph_id       :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Dataset < ActiveRecord::Base
  belongs_to :graph
end
