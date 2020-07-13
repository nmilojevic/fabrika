class AddRoleForRefineryUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :refinery_authentication_devise_users, :role, :integer
  end
end
