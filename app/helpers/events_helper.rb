module EventsHelper
  def event_color(event)
    color = "#1796b0"
    if current_user.user? && !current_user.subscribed_event_types.try(:include?,event.event_type)
      color = "#B3B1B0"
    elsif event.past?
      color = "#B3B1B0"
    elsif event.reserved_for?(current_user)
      color = "#1FC364"
    elsif current_user.reserved_for?(event.start_date, event.event_type)
      color = "#B3B1B0"
    elsif event.full? 
      color = "#D40909"
    end 
    color
  end
end
