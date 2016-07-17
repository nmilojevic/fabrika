desc "This task is called by the Heroku scheduler add-on"
task :expire_members => :environment do
    User.ready.user.where("membership_updated_at <= ?", Time.current - 30.days).each do |user|
      if user.membership_updated_at <= Time.current - 35.days
        CustomerMailer.membership_expired_email(user).deliver
        user.deactivated!
      else
        CustomerMailer.membership_expires_soon_email(user).deliver
        user.expired!
      end
    end 
end