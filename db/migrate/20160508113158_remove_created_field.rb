class RemoveCreatedField < ActiveRecord::Migration[4.2]
  def change
    remove_column  :pressure_data, :created_at 
    remove_column  :pressure_data, :updated_at    
  end
end
