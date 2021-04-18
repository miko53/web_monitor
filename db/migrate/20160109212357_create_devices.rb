class CreateDevices < ActiveRecord::Migration[4.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.string :location
      t.string :address

      t.timestamps null: false
    end
  end
end
