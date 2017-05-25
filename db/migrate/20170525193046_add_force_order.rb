class AddForceOrder < ActiveRecord::Migration
  def change
    add_column :actuators, :forced, :boolean
  end
end
