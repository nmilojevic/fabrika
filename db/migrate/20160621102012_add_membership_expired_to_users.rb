class AddMembershipExpiredToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :membership_expired, :boolean, default: false
  end
end
