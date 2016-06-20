class AddEventTypeForEvents < ActiveRecord::Migration
  def change
    add_column :events, :event_type, :integer, default: 0
  end
end
