class ModifyOperations < ActiveRecord::Migration
  def change
    remove_column  :operations, :beginPeriod
    add_column :operations,  :endPeriod, :datetime
    add_column :operations, :period_unit, :string
    add_column :operations, :number_samples, :integer
  end
end
