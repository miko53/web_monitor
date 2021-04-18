class AddAddressUnique < ActiveRecord::Migration[4.2]
  def change
    add_index :devices, :address, :unique => true
  end
end
