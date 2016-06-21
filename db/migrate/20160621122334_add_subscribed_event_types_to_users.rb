class AddSubscribedEventTypesToUsers < ActiveRecord::Migration
  def change
    add_column :users, :subscribed_event_types, :string
  end
end
