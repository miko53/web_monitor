class ChangePeriodUnitType < ActiveRecord::Migration
  def change
    remove_column  :operations, :period_unit
    add_column :operations, :period_unit, :integer
  end
end
