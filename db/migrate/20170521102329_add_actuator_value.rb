class AddActuatorValue < ActiveRecord::Migration[4.2]
  def change
   add_column  :actuators, :value, :string
  end
end
