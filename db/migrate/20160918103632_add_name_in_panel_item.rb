class AddNameInPanelItem < ActiveRecord::Migration[4.2]
  def change
    add_column :panel_items, :name, :string
  end
end
