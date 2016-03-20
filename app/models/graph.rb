# == Schema Information
#
# Table name: graphs
#
#  id         :integer          not null, primary key
#  report_id  :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  dataset_id :integer
#  title      :string
#

class Graph < ActiveRecord::Base
  belongs_to :report
  has_many :datasets, :dependent => :destroy
  accepts_nested_attributes_for :datasets, :allow_destroy => true
  
end
