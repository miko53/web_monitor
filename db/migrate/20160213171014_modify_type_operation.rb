class ModifyTypeOperation < ActiveRecord::Migration
  def change
    remove_column  :operations, :type
    add_column :operations, :calcul_type, :string
  end
end
