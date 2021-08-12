class AddIndexOnCalculatedData < ActiveRecord::Migration[6.1]
  def change
    add_index :calculated_data, [:beginPeriod, :operation_id] , :order => { :beginPeriod => :desc, :operation_id => :asc }
  end
end
