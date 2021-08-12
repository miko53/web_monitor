class AddDateEventOn < ActiveRecord::Migration[6.0]
  def change
    add_column :operations, :eventDateTime, :datetime
  end
end
