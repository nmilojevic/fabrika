desc "This task is called by the Heroku scheduler add-on"
task :expire_members => :environment do
	User.user.active.user.where("membership_updated_at <= ?", Time.current - 24.days).each do |user|
		CustomerMailer.membership_expires_soon_email(user).deliver
		user.expired!
	end

	User.user.expired.user.where("membership_updated_at <= ?", Time.current - 30.days).each do |user|
		CustomerMailer.membership_expired_email(user).deliver
		user.deactivated!
	end
end
