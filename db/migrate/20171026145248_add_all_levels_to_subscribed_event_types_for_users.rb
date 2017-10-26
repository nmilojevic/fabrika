class AddAllLevelsToSubscribedEventTypesForUsers < ActiveRecord::Migration
  def change
    User.where.not(status:1).each do |a|
      if a.subscribed_event_types.blank? && a.admin?
        a.subscribed_event_types = Event.event_types.keys
      else
        if a.subscribed_event_types.blank?
          a.subscribed_event_types = []
        end          
        a.subscribed_event_types << "all_levels"
      end
      a.save
    end
  end
end
