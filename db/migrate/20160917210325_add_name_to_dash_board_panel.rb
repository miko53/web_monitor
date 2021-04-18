class AddNameToDashBoardPanel < ActiveRecord::Migration[4.2]
  def change
    add_column :dash_board_panels, :name, :string
    remove_column  :panel_items, :name
    
  end
end
