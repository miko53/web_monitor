class CreateDeviceOfReports < ActiveRecord::Migration[4.2]
  def change
    create_table :device_of_reports do |t|
      t.string :deviceName
      t.integer :flowID
      t.integer :report_id

      t.timestamps null: false
    end
    add_index :device_of_reports, :report_id
  end
end
