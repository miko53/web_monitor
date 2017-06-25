class AddHeaderOrder < ActiveRecord::Migration
  def change
    add_column :range_commands, :command, :string
  end
end
