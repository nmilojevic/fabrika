class User < ActiveRecord::Base
  enum role: [:user, :admin, :coach]
  enum status: [:active, :pending, :expired, :deactivated]
  validates :email, :presence => true, length: { maximum: 50 }
  validates :email, :email => true, :uniqueness => true
  validates :name, :presence => true, length: { maximum: 50 } #, too_long: "First and last name are too long. Maximum combined length is 50 characters." }
  validates :password, :presence => true, :length => { :in => 6..120 }, :if => :password_required?
  validates_confirmation_of :password, :if => :password_required?

  has_many :plugins,-> { order 'position ASC'}, :class_name => "Refinery::UserPlugin"
  accepts_nested_attributes_for :plugins
  after_initialize :set_default_role, :if => :new_record?
  after_create :send_admin_mail
  has_and_belongs_to_many :events
  scope :ready, -> { where(status:[0,2]) }
  def password_required?
   !persisted? || !password.blank? || !password_confirmation.blank?
  end

  def set_default_role
    self.role ||= :user
  end

  def events_to_hash_per_day(from, to)
    week_events = events.where(start_date:from.to_datetime.beginning_of_day..to.to_datetime.beginning_of_day)
    Hash[*week_events.map{|ue| [ue.start_date.strftime("%Y-%m-%d"), ue.event_type]}.flatten]
  end

  def events_to_hash_per_hour(from, to)
    week_events = events.where(start_date:from.to_datetime.beginning_of_day..to.to_datetime.beginning_of_day)
    Hash[*week_events.map{|ue| [ue.start_date.strftime("%Y-%m-%d %H:%M"), ue.event_type]}.flatten]
  end

  def reserved_for?(date, event_type)
    events.where(start_date:date.beginning_of_day..date.end_of_day, event_type:Event.event_types[event_type]).size > 0
  end

  def authorized_plugins
    plugins.collect { |p| p.name } | ::Refinery::Plugins.always_allowed.names
  end

  def has_plugin?(name)
    active_plugins.names.include?(name)
  end

  def active_plugins
    @active_plugins ||= Refinery::Plugins.new(
      Refinery::Plugins.registered.select do |plugin|
        admin? || authorised_plugins.include?(plugin.name)
      end
    )
  end

  def plugins=(plugin_names)
    if persisted? # don't add plugins when the user_id is nil.
      ::Refinery::UserPlugin.delete_all(:user_id => id)

      plugin_names.each_with_index do |plugin_name, index|
        plugins.create(:name => plugin_name, :position => index) if plugin_name.is_a?(String)
      end
    end
  end

  def maintainer?
    admin? || coach?
  end

  def has_role?(title)
    # raise ::ArgumentError, "Role should be the title of the role not a role object." if title.is_a?(::Refinery::Authentication::Devise::Role)
    admin?
  end


  def authorized_plugins
    plugins.collect(&:name) | ::Refinery::Plugins.always_allowed.names
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
   devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication?
    super && (active? || expired?)
  end

  def username
    name
  end

  def self.send_group_email
    @users = User.all
    total = @users.size
    count = 0
    @users.each do |user|
      count = count + 1
      CustomerMailer.new_web_site_email(user).deliver
      if (count % 50) == 0
        sleep(30)
      end
    end
  end

  def send_admin_mail
    self.update(membership_updated_at: Time.current)
    CustomerMailer.signup_confirmation_email(self).deliver
  end

  def landing_url
    active_plugins.in_menu.first_url_in_menu
  end

  def can_delete?(user_to_delete = self)
    user_to_delete.persisted? &&
      !user_to_delete.admin? &&
      User.admin.any? &&
      id != user_to_delete.id
  end

  def can_edit?(user_to_edit = self)
    user_to_edit.persisted? && (user_to_edit == self || self.admin?)
  end

  def inactive_message
    if pending?
      :not_approved
    elsif deactivated?
      :membership_expired
    else
      super # Use whatever other message
    end
  end

  def self.roles_mapping
    { "Član" => :user, "Administrator" => :admin , "Trener" => :coach }
  end

end
