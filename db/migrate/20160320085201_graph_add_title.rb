class GraphAddTitle < ActiveRecord::Migration
  def change
    add_column :graphs, :title, :string
  end
end
