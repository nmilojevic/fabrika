class AddMembershipUpdatedToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :membership_updated_at, :date
  end
end
