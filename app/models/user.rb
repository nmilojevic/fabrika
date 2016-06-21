class User < ActiveRecord::Base
  enum role: [:user, :admin]
  after_initialize :set_default_role, :if => :new_record?
  after_create :send_admin_mail
  has_and_belongs_to_many :events
  def set_default_role
    self.role ||= :user
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def active_for_authentication? 
    super && approved? && !membership_expired
  end 

  def send_admin_mail
    self.update(membership_updated: Time.current)
    CustomerMailer.signup_confirmation_email(self).deliver
  end

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

end
