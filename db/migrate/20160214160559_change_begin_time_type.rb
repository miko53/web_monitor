class ChangeBeginTimeType < ActiveRecord::Migration[4.2]
  def change
    remove_column  :operations, :beginPeriod
    add_column :operations, :beginPeriod, :time
  end
end
