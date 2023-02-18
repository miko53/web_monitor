class WindDirectionsAddIndexRemoveOld < ActiveRecord::Migration[6.1]
  def change
    add_index :wind_directions, :dateTime, order: { dateTime: :desc }
    remove_column  :wind_directions, :created_at 
    remove_column  :wind_directions, :updated_at    
  end
end
