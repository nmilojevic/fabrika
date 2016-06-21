class LongTasks

  def expire_members
    User.where(approved:true, membership_expired: false, role: User.roles[:user]).where("membership_updated <= ?", Time.current - 35.days).each do |user|
      CustomerMailer.membership_expired_email(user).deliver
      user.update(membership_expired:true)
    end 
  end
  handle_asynchronously :expire_members, :run_at => Proc.new { 35.days.from_now }
 
  def warn_members
    User.where(approved:true, membership_expired: false, role: User.roles[:user]).where("membership_updated <= ?", Time.current - 30.days).each do |user|
      CustomerMailer.membership_expires_soon_email(user).deliver
      user.update(membership_expired:true)
    end
  end
  handle_asynchronously :warn_members, :run_at => Proc.new { 30.days.from_now }

end