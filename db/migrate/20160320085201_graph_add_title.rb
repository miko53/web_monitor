class GraphAddTitle < ActiveRecord::Migration[4.2]
  def change
    add_column :graphs, :title, :string
  end
end
