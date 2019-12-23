module Eventable
  extend ActiveSupport::Concern

  included do
    before_action :set_event, only: [:reserve_event, :cancel_event]
  end

  def events_hash
    EventsFetcher.new(user: current_user, start_date: params['from'], end_date: params['to']).fetch_events
  end

  def event_types_hash
    Event.event_types_hash
  end

  def reserve_event
    recurring_event = params['recurring_event']
    origin_event = @event
    if recurring_event == "true" && origin_event.rec_type != ''
      start_date = Time.at(params['event_length'].to_i).strftime('%Y-%m-%d %H:%M:%S')
      end_date= start_date.to_datetime + origin_event.event_length.seconds
      end_date = end_date.strftime("%Y-%m-%d %H:%M:%S")
      event_length= params['event_length']
      event = Event.find_or_create_by(:start_date => start_date, :event_pid => origin_event.id)
      event.update(:end_date => end_date, :text => origin_event.text,
                   :rec_type => '', :max_users => origin_event.max_users, :instructor_name => origin_event.instructor_name, :event_type => origin_event.event_type, :event_length => event_length)
    else
      event = origin_event
    end
    if event.full?
      @error = "Termin je pun. Pokušajte kasnije, u slučaju da neko otkaže."
    elsif event.reserved_for?(current_user)
      @error = "Već ste rezervisali trening"
    elsif current_user.reserved_for?(event.start_date, event.event_type)
      @error = "Već ste rezervisali ovaj tip treninga danas"
    elsif event.past?
      @error = "Nije moguće rezervisati trening."
    elsif !current_user.subscribed_event_types.try(:include?, event.event_type)
      @error = "Nije moguće rezervisati ovaj tip treninga."
    else
      event.users << current_user
    end
    render :json => {success:@error.blank?, message:@error}
  end



  def cancel_event
    if @event.users.exists?(current_user)
      @event.users.delete(current_user)
      render :json => {"success":true, message: nil}
    else
      render :json => {"success":false, message: "Rezervacija ovog treninga nije pronadjena."}
    end
  end

  private

  def set_event
    @event = Event.find(params['id'])
  end
end
