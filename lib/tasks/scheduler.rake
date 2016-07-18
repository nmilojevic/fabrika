desc "This task is called by the Heroku scheduler add-on"
task :expire_members => :environment do
    User.active.user.where("membership_updated_at <= ?", Time.current - 30.days).each do |user|
      CustomerMailer.membership_expires_soon_email(user).deliver
      user.expired!
    end 
    User.expired.user.where("membership_updated_at <= ?", Time.current - 35.days).each do |user|
      CustomerMailer.membership_expired_email(user).deliver
      user.deactivated!
    end
    
end