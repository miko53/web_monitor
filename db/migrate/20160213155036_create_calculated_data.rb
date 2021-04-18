class CreateCalculatedData < ActiveRecord::Migration[4.2]
  def change
    create_table :calculated_data do |t|
      t.float :value
      t.datetime :beginPeriod

      t.timestamps null: false
    end
  end
end
