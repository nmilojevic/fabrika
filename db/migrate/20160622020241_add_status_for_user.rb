class AddStatusForUser < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :approved
    remove_column :users, :membership_expired
    add_column :users, :status, :integer, default: 0
  end
end
