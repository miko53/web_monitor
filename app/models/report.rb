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
#  user_id         :integer
#

class Report < ActiveRecord::Base
  belongs_to :user
  has_many :graphs, :dependent => :destroy
  has_many :datasets, :through => :graphs
  accepts_nested_attributes_for :graphs, :allow_destroy => true
end
