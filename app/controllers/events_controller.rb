class EventsController < ApplicationController
 include Eventable
 before_action :admin_only, only: [:db_action]

 def data
   render :json => {"data": events_hash, "collections": {"type":event_types_hash}}
 end

 def db_action
   mode = params['!nativeeditor_status']
   id = params['id']
   start_date = params['start_date']
   end_date = params['end_date']

   text = params['text']
   rec_type = params['rec_type'] == nil ? "" : params['rec_type']
   max_users = params['max_users']
   event_type = params['event_type']
   event_length = params['event_length']
   instructor_name = params['instructor_name']
   event_pid = params['event_pid']
   tid = id

   case mode
     when 'inserted'
       event = Event.create :start_date => start_date, :end_date => end_date, :text => text, :instructor_name => instructor_name,
                            :rec_type => rec_type, :max_users => max_users, :event_type => event_type, :event_length => event_length, :event_pid => event_pid
       tid = event.id
       if rec_type == 'none'
         mode = 'deleted'
       end
     when 'deleted'
       if rec_type != ''
         Event.where(event_pid: id).destroy_all
       end

       if event_pid != 0 and event_pid != ''
         event = Event.find(id)
         event.rec_type = 'none'
         event.users.clear
         event.save
       else
         Event.find(id).destroy
       end

     when 'updated'
       if rec_type != ''
         Event.where(event_pid: id).destroy_all
       end
       event = Event.find(id)
       event.start_date = start_date
       event.end_date = end_date
       event.text = text
       event.rec_type = rec_type
       event.event_type = event_type
       event.instructor_name = instructor_name
       event.event_length = event_length
       event.max_users = max_users
       event.event_pid = event_pid
       event.save
   end

   render :json => {
              :type => mode,
              :sid => id,
              :tid => tid,
          }
 end

 private

 def admin_only
   unless current_user.admin?
     redirect_to :back, :alert => "Access denied."
   end
 end

end
