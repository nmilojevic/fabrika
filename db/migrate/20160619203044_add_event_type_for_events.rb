class AddEventTypeForEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :event_type, :integer, default: 0
  end
end
