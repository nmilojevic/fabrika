class ChangeSubscribedEventTypesForUsers < ActiveRecord::Migration
  def change
    User.all.each do |a|
      a.subscribed_event_types = JSON.parse(a.subscribed_event_types).join(', ') if a.subscribed_event_types.present?
      a.save
    end
    change_column :users, :subscribed_event_types, :text, array: true, default: [], using: "(string_to_array(subscribed_event_types, ','))"
  end
end
