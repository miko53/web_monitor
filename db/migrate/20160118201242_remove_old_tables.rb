class RemoveOldTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :temperatureDatas
    drop_table :humidityDatas
    drop_table :voltageDatas
  end
end
