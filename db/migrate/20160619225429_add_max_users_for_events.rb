class AddMaxUsersForEvents < ActiveRecord::Migration
  def change
    add_column :events, :max_users, :integer, default: 10
  end
end
