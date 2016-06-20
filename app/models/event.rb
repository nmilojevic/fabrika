class Event < ActiveRecord::Base
  enum event_type: [:crossfit, :bootcamp, :weightlifting, :power_joga, :open_jim]

  has_and_belongs_to_many :users

  def reserved_for?(user)
    users.exists?(user)
  end

  def full?
    users.size >= max_users
  end

  def past?
    start_date < Time.current + 1.hour
  end

end
