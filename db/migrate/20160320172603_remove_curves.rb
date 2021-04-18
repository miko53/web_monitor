class RemoveCurves < ActiveRecord::Migration[4.2]
  def change
    drop_table :curves
  end
end
