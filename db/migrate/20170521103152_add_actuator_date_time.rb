class AddActuatorDateTime < ActiveRecord::Migration
  def change
   add_column  :actuators, :refreshDateTime, :dateTime
  end
end
