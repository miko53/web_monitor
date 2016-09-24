class AddNameToDashBoardPanel < ActiveRecord::Migration
  def change
    add_column :dash_board_panels, :name, :string
    remove_column  :panel_items, :name
    
  end
end
