class AddActuatorDateTime < ActiveRecord::Migration[4.2]
  def change
   add_column  :actuators, :refreshDateTime, :dateTime
  end
end
