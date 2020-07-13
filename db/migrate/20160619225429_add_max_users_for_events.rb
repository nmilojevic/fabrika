class AddMaxUsersForEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :max_users, :integer, default: 10
  end
end
