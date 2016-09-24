class AddNameInPanelItem < ActiveRecord::Migration
  def change
    add_column :panel_items, :name, :string
  end
end
