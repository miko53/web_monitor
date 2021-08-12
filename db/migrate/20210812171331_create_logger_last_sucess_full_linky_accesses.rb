class CreateLoggerLastSucessFullLinkyAccesses < ActiveRecord::Migration[6.1]
  def change
    create_table :logger_last_sucess_full_linky_accesses do |t|
      t.integer :device_id
      t.datetime :last_ok_date
    end
  end
end
