class AddGraphId < ActiveRecord::Migration
  def change
    add_column :curves, :graph_id, :integer    
    
    add_index :curves, :graph_id
  end
  
  
end
