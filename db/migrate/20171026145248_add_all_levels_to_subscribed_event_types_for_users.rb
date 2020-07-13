class AddAllLevelsToSubscribedEventTypesForUsers < ActiveRecord::Migration[4.2]
  def change
    User.where.not(status:1).each do |a|
      if a.subscribed_event_types.blank? && a.admin?
        a.subscribed_event_types = Event.event_types.keys
      else
        if a.subscribed_event_types.blank?
          a.subscribed_event_types = []
        end
        if !a.subscribed_event_types.include?("all_levels")          
          a.subscribed_event_types << "all_levels"
        end
      end
    end
  end
end
