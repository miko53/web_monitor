class AddGraphId < ActiveRecord::Migration[4.2]
  def change
    add_column :curves, :graph_id, :integer    
    
    add_index :curves, :graph_id
  end
  
  
end
