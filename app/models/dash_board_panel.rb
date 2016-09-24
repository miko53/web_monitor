# == Schema Information
#
# Table name: dash_board_panels
#
#  id            :integer          not null, primary key
#  dash_board_id :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  name          :string
#

class DashBoardPanel < ActiveRecord::Base
  belongs_to :dash_board
  has_many :panel_item, :dependent => :destroy
end
