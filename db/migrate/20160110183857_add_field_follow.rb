class AddFieldFollow < ActiveRecord::Migration
  def change
    add_column :devices, :follow, :boolean
  end
end
