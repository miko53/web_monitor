class CreateDashBoards < ActiveRecord::Migration
  def change
    create_table :dash_boards do |t|
      t.integer :user_id
      t.timestamps null: false
    end
  end
end
