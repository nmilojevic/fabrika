class Event < ActiveRecord::Base
  enum event_type: [:crossfit, :bootcamp, :weightlifting, :power_yoga, :open_gym, :all_levels]

  has_and_belongs_to_many :users

  def reserved_for?(user)
    users.exists?(user)
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
