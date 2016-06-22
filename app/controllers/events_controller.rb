class EventsController < ApplicationController
 include EventsHelper
 before_action :authenticate_user!

 def data
   events = Event.all
   event_json = events.map {|event| {
              :id => event.id,
              :start_date => event.start_date.to_formatted_s(:db),
              :end_date => event.end_date.to_formatted_s(:db),
              :text => event.text,
              :rec_type => event.rec_type,
              :event_type => event.event_type,
              :max_users => event.max_users,
              :event_length => event.event_length,
              :event_pid => event.event_pid,
              :users => event.users.size,
              :reserved => event.reserved_for?(current_user),
              :full => event.full?,
              :past => event.past?,
              :color => event_color(event),
              :allowed => current_user.admin? || current_user.subscribed_event_types.try(:include?, event.event_type)
          }}
    types_json =  Event.event_types.map{|type|  {key:type[0], label:type[0].humanize, value: type[0]}}
    render :json => {"data": event_json, "collections": {"type":types_json}}
 end
 
 def reserve_event
  event = Event.find(params['id'])
  event.users << current_user
  render :json => {"success":true}
 end

 def cancel_event
  event = Event.find(params['id'])
  event.users.delete(current_user)
  render :json => {"success":true}
 end
 
 def db_action
   mode = params['!nativeeditor_status']
   id = params['id']
   start_date = params['start_date']
   end_date = params['end_date']
   text = params['text']
   rec_type = params['rec_type']
   max_users = params['max_users']
   event_type = params['event_type']
   event_length = params['event_length']
   event_pid = params['event_pid']
   tid = id

   case mode
     when 'inserted'
       event = Event.create :start_date => start_date, :end_date => end_date, :text => text,
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

end