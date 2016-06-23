Rails.application.routes.draw do
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'visitors#index', :ad => "home_root"
  devise_for :users
  resources :users
  match "events/:id/reserve_event", :to => "events#reserve_event", :as => "reserve_event", :via => "post"
  match "events/:id/cancel_event", :to => "events#cancel_event", :as => "cancel_event", :via => "post"
  match "users/:id/renew_membership", :to => "users#renew_membership", :as => "renew_membership", :via => "get"
  
  match "users/:id/approve", :to => "users#approve", :as => "approve_user", :via => "get"
  match "schedule_data", :to => "events#data", :as => "data", :via => "get"
  match "db_action", :to => "events#db_action", :as => "db_action", :via => "post"

end
