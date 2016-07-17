module EventsHelper
  def event_color(event, map, map_per_hour)
    color = "#1796b0"
    if current_user.user? && !current_user.subscribed_event_types.try(:include?,event.event_type)
      color = "#B3B1B0"
    elsif event.reserved_for?(current_user)
      color = "#1FC364"
    elsif map_per_hour[event.start_date.strftime("%Y-%m-%d %H:%M")].present?
      color = "#B3B1B0"
    elsif event.past?
      color = "#B3B1B0"
    elsif map[event.start_date.strftime("%Y-%m-%d")] == event.event_type
      color = "#B3B1B0"
    elsif event.full? 
      color = "#D40909"
    end 
    color
  end
end
