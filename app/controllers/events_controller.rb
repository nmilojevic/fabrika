class EventsController < ApplicationController
 include EventsHelper
 before_action :authenticate_user!
 before_action :admin_only, only: [:db_action]


 def data
   events = Event.all
   event_json = events.map {|event| {
              :id => event.id,
              :start_date => event.start_date.strftime("%Y-%m-%d %H:%M:%S"),
              :end_date => event.end_date.strftime("%Y-%m-%d %H:%M:%S"),
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
              :instructor_name => event.instructor_name.present? ? event.instructor_name : "",
              :color => event_color(event),
              :reserved_by => current_user.admin? ? event.users.map{|user| "#{user.name.to_s} (#{user.email})"} : [],
              :allowed => current_user.admin? || current_user.subscribed_event_types.try(:include?, event.event_type)
          }}
    types_json =  Event.event_types.map{|type|  {key:type[0], label:type[0].humanize, value: type[0]}}
    render :json => {"data": event_json, "collections": {"type":types_json}}
 end
 
 def reserve_event
  recurring_event = params['recurring_event']
  origin_event = Event.find(params['id'])
  if recurring_event == "true"
    start_date = Time.at(params['event_length'].to_i).strftime('%Y-%m-%d %H:%M:%S')
    end_date= start_date.to_datetime + origin_event.event_length.seconds
    event_length= params['event_length']
    p "recurring_event"
    event = Event.create :start_date => start_date, :end_date => end_date, :text => origin_event.text,
                          :rec_type => '', :max_users => origin_event.max_users, :instructor_name => origin_event.instructor_name, :event_type => origin_event.event_type, :event_length => event_length, :event_pid => origin_event.id
  else 
     event = origin_event  
  end
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
       p event
     when 'deleted'
       if rec_type != ''
         Event.where(event_pid: id).destroy_all
       end

       if event_pid != 0 and event_pid != ''
          p "2"*100
         event = Event.find(id)
         event.rec_type = 'none'
         event.save
       else
          p "3"*100
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