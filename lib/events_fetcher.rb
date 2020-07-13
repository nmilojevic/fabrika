class EventsFetcher

  def initialize(user:, start_date:, end_date:)
    self.user = user
    self.start_date = start_date
    self.end_date = end_date
  end

  attr_accessor :user, :start_date, :end_date

  def fetch_events
    to_event = end_date.to_datetime.end_of_day
    if user.user?
      tomorrow = (Time.current.middle_of_day + (Time.current < Time.current.middle_of_day ? 0.day : 1.day)).end_of_day
      if to_event > tomorrow
        to_event = tomorrow
      end
    end

    events = Event.where(start_date:start_date.to_datetime.beginning_of_day..to_event).where(rec_type:["none",nil, ""])+Event.where.not(rec_type:["none",nil, ""])
    events.map {|event| event_to_hash(event)}
  end

  private

  def hash_per_hour
    @hash_per_hour ||= user.events_to_hash_per_hour(start_date, end_date)
  end

  def hash_per_day
    @hahs_per_day ||=user.events_to_hash_per_day(start_date, end_date)
  end

  def event_to_hash(event)
    hash = {
      :id => event.id,
      :start_date => event.start_date.strftime("%Y-%m-%d %H:%M:%S"),
      :end_date => event.end_date.strftime("%Y-%m-%d %H:%M:%S"),
      :text => event.text,
      :rec_type => event.rec_type,
      :event_type => event.event_type,
      :max_users => event.max_users,
      :event_length => event.event_length,
      :event_pid => event.event_pid,
      :users => event.users.size,
      :reserved => event.reserved_for?(user),
      :full => event.full?,
      :past => event.past?,
      :instructor_name => event.instructor_name.present? ? event.instructor_name : "",
      :reserved_by => user.maintainer? ? event.users.map{|event_user| "#{event_user.name.to_s} (#{event_user.email})"} : [],
      :allowed => user.maintainer? || user.subscribed_event_types.try(:include?, event.event_type)
    }
    unless user.is_a?(ApiUser)
      hash.merge!(
        {
          :reserved_map => hash_per_day,
          :reserved_hour_map => hash_per_hour,
          :color => event_color(event),
          :reserved_for_today => hash_per_day[event.start_date.strftime("%Y-%m-%d")] == event.event_type,
          :reserved_in_same_time => hash_per_hour[event.start_date.strftime("%Y-%m-%d %H:%M")].present?,
        })
    end
    hash
  end

  def event_color(event)
    color = "#1796b0"
    if user.user? && !user.subscribed_event_types.try(:include?,event.event_type)
      color = "#B3B1B0"
    elsif event.reserved_for?(user)
      color = "#1FC364"
    elsif hash_per_hour[event.start_date.strftime("%Y-%m-%d %H:%M")].present?
      color = "#B3B1B0"
    elsif event.past?
      color = "#B3B1B0"
    elsif hash_per_day[event.start_date.strftime("%Y-%m-%d")] == event.event_type
      color = "#B3B1B0"
    elsif event.full?
      color = "#D40909"
    end
    color
  end

end
