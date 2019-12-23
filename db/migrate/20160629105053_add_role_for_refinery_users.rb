class AddRoleForRefineryUsers < ActiveRecord::Migration
  def change
    add_column :refinery_authentication_devise_users, :role, :integer
  end
end
