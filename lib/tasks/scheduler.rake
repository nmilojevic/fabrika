desc "This task is called by the Heroku scheduler add-on"
task :expire_members => :environment do
    User.active.user.where("membership_updated_at <= ?", Time.current - 30.days).each do |user|
      if user.membership_updated_at <= Time.current - 35.days
        CustomerMailer.membership_expired_email(user).deliver
        user.expired!
      else
        CustomerMailer.membership_expires_soon_email(user).deliver
      end
    end 
end