class AddSubscribedEventTypesToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :subscribed_event_types, :string
  end
end
