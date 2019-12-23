class Api::EventsController < Api::BaseController
  include Eventable

  def events
    render :json => {"events": events_hash}
  end

  def event_types
    render :json => {"event_types": event_types_hash}
  end
end
