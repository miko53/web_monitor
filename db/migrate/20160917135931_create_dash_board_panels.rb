class CreateDashBoardPanels < ActiveRecord::Migration
  def change
    create_table :dash_board_panels do |t|
      t.integer :dash_board_id
      t.timestamps null: false
    end
  end
end
