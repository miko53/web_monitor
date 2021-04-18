class AddForceOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :actuators, :forced, :boolean
  end
end
