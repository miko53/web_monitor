# == Schema Information
#
# Table name: devices
#
#  id         :integer          not null, primary key
#  name       :string
#  location   :string
#  address    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  follow     :boolean
#

class Device < ActiveRecord::Base
  validates :address, :presence => true
  has_many :sensors, :dependent => :destroy
  has_many :actuators, :dependent => :destroy
end
