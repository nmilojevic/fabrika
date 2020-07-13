class AddNewColumnsForRefineryUsers < ActiveRecord::Migration[4.2]
  def change
     add_column :refinery_authentication_devise_users, :name, :string
     add_column :refinery_authentication_devise_users, :membership_updated_at, :date
     add_column :refinery_authentication_devise_users, :subscribed_event_types, :string
     add_column :refinery_authentication_devise_users, :status, :integer, default: 1
  end
end
