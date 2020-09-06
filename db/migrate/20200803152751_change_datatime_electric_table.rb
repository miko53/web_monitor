class ChangeDatatimeElectricTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :electrical_power_data, :date_time, :datetime
    add_column :electrical_power_data, :dateTime, :datetime
  end
end
