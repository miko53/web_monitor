class CreateDashBoardPanels < ActiveRecord::Migration[4.2]
  def change
    create_table :dash_board_panels do |t|
      t.integer :dash_board_id
      t.timestamps null: false
    end
  end
end
