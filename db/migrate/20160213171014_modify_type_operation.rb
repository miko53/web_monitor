class ModifyTypeOperation < ActiveRecord::Migration[4.2]
  def change
    remove_column  :operations, :type
    add_column :operations, :calcul_type, :string
  end
end
