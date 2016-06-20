module EventsHelper
  def event_color(event)
     color = "#1796b0"
    if event.past?
      color = "#B3B1B0"
    elsif event.reserved_for?(current_user)
      color = "#dff0d8"
    elsif event.full? 
      color = "#D40909"
    end 
    color
  end
end
