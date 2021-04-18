class CreatePanelItems < ActiveRecord::Migration[4.2]
  def change
    create_table :panel_items do |t|
      t.integer :dash_board_panel_id
      t.string :name
      t.string :sensor_name
      t.string :operation_name
      t.timestamps null: false
    end
  end
end
