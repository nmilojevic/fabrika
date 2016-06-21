class AddMembershipUpdatedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :membership_updated_at, :date
  end
end
