class AddHeaderOrder < ActiveRecord::Migration[4.2]
  def change
    add_column :range_commands, :command, :string
  end
end
