class CreateOperationOfReports < ActiveRecord::Migration[4.2]
  def change
    create_table :operation_of_reports do |t|
      t.string :deviceName
      t.integer :operationID
      t.integer :report_id

      t.timestamps null: false
    end
  end
end
