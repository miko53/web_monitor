class ChangePeriodUnitType < ActiveRecord::Migration[4.2]
  def change
    remove_column  :operations, :period_unit
    add_column :operations, :period_unit, :integer
  end
end
