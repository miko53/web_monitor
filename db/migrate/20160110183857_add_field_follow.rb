class AddFieldFollow < ActiveRecord::Migration[4.2]
  def change
    add_column :devices, :follow, :boolean
  end
end
