class AddActuatorValue < ActiveRecord::Migration
  def change
   add_column  :actuators, :value, :string
  end
end
