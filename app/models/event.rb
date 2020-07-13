class Event < ActiveRecord::Base
  enum event_type: [:crossfit, :bootcamp, :beginners, :strongman, :open_gym, :all_levels, :weightlifting, :morning, :functional_bodybuilding]

  has_and_belongs_to_many :users

  def self.event_types_hash
    Event.event_types.map{|type|  {key:type[0], label:type[0].humanize, value: type[0]}}
  end

  def reserved_for?(user)
    users.exists?(user.id)
  end

  def reserve

  end

  def full?
    users.size >= max_users
  end

  def past?
    if open_gym?
      @past = end_date < Time.current + 1.hour
    elsif start_date.hour < 9
      @past = start_date < Time.current + 8.hour
    else
      @past = start_date < Time.current + 1.hour
    end
    @past
  end

end
