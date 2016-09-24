# == Schema Information
#
# Table name: panel_items
#
#  id                  :integer          not null, primary key
#  dash_board_panel_id :integer
#  sensor_name         :string
#  operation_name      :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  name                :string
#

class PanelItem < ActiveRecord::Base
  belongs_to :dash_board_panel
end
