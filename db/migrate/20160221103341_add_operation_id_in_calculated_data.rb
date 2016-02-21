class AddOperationIdInCalculatedData < ActiveRecord::Migration
  def change
    add_column :calculated_data, :operation_id, :integer    
  end
end
