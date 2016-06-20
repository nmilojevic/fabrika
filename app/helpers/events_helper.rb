module EventsHelper
  def event_color(event)
     color = "#1796b0"
    if event.past?
      color = "#FF5733"
    elsif event.reserved_for?(current_user)
      color = "#6EFF33"
    elsif event.full? 
      color = "#FF5733"
    end 
    color
  end
end
