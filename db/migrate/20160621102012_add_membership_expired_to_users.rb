class AddMembershipExpiredToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership_expired, :boolean, default: false
  end
end
