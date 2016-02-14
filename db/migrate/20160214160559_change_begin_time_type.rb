class ChangeBeginTimeType < ActiveRecord::Migration
  def change
    remove_column  :operations, :beginPeriod
    add_column :operations, :beginPeriod, :time
  end
end
