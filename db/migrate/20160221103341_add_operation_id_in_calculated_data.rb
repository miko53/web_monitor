class AddOperationIdInCalculatedData < ActiveRecord::Migration[4.2]
  def change
    add_column :calculated_data, :operation_id, :integer    
  end
end
