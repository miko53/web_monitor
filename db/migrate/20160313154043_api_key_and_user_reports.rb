class ApiKeyAndUserReports < ActiveRecord::Migration
  def change
    add_column :users, :api_key, :string
    add_column :reports, :user_id, :integer
  end
end
