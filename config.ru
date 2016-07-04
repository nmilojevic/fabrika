# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

queue_names = Rails.application.config.enabled_long_tasks.split(' ')
queue_names.each do |queue_name|
  # start recurring job with a separate queue name on each restart if it's not already running
  if !Delayed::Job.exists?(:queue => queue_name, :failed_at => nil)
    p "Starting background job for LongTask.new.#{queue_name}"
    LongTasks.new.send(queue_name)
  end
end

run Rails.application
