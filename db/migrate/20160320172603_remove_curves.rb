class RemoveCurves < ActiveRecord::Migration
  def change
    drop_table :curves
  end
end
