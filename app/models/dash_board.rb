# == Schema Information
#
# Table name: dash_boards
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DashBoard < ActiveRecord::Base
  belongs_to :user
  has_many :dash_board_panel, :dependent => :destroy
end
