class RemoveOldTables < ActiveRecord::Migration
  def change
    drop_table :temperatureDatas
    drop_table :humidityDatas
    drop_table :voltageDatas
  end
end
