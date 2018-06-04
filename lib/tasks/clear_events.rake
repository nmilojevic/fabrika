desc "This task is called by the Heroku scheduler add-on"
task :clear_events => :environment do
  Event.where("end_date < ?", Time.current - 6.months).where(rec_type:["none",nil, ""]).delete_all
  
  events = Event.where("start_date > ?", Time.current - 5.months).where("start_date < ?", Time.current - 1.months).where("end_date < ?", Time.current - 1.months).where(rec_type:["none",nil, ""])
  events.each do |event|
    event.users.clear
  end
end