Rails.application.routes.draw do
  #API namespace for JSON requests at /api/sign_[in|out|]
  namespace :api do
    devise_for :users, defaults: { format: :json },
                                class_name: 'ApiUser',
                                skip: [:registrations, :invitations, :passwords, :confirmations, :unlocks],
                                path: '',
                                controllers: {
                                  sessions: 'api/sessions',
                                },
                                path_names: { sign_in: 'login',
                                              sign_out: 'logout' }
    put "events/:id/reservation", :to => "events#reserve_event"
    delete "events/:id/reservation", :to => "events#cancel_event"
    get "events", :to => "events#events"
    get "event_types", :to => "events#event_types"
  end

  # This line mounts Refinery's routes at the root of your application.
  # This means, any requests to the root URL of your application will go to Refinery::PagesController#home.
  # If you would like to change where this extension is mounted, simply change the
  # configuration option `mounted_path` to something different in config/initializers/refinery/core.rb
  #
  # We ask that you don't use the :as option here, as Refinery relies on it being the default of "refinery"
  match "*all" => "application#route_options", :constraints => { :method => "OPTIONS" }, :via => "get"


  mount Refinery::Core::Engine, at: Refinery::Core.mounted_path
  get "/static/:page" => "pages#show"
  get "schedule" => "pages#schedule", :as => "schedule"
  namespace :admin do
    resources :users
    root to: "users#index"
  end
  root to: 'refinery/pages#home', :ad => "home_root"
  devise_for :users
    resources :users
  #match '/contacts', to: 'refinery/pages#create', via: 'post'
  resources "contacts", only: [:new, :create]
  match "events/:id/reserve_event", :to => "events#reserve_event", :as => "reserve_event", :via => "post"
  match "events/:id/cancel_event", :to => "events#cancel_event", :as => "cancel_event", :via => "post"
  match "users/:id/renew_membership", :to => "users#renew_membership", :as => "renew_membership", :via => "get"
  match "users/:id/update_membership", :to => "users#update_membership", :as => "update_membership", :via => "post"
  match "users/:id/update_subscribed_event_types", :to => "users#update_subscribed_event_types", :as => "update_subscribed_event_types", :via => "patch"
  match "impersonate/:id" => 'users#impersonate', :via => :get, :as => :impersonate
  match "unimpersonate_user" => 'users#unimpersonate_user', :via => :get, :as => :unimpersonate_user
  match "users/create_user", :to => "users#create_user", :as => "create_user", :via => "post"


  match "users/:id/destroy", :to => "users#destroy", :as => "delete_user", :via => "post"

  match "users/:id/approve", :to => "users#approve", :as => "approve_user", :via => "get"
  match "schedule_data", :to => "events#data", :as => "data", :via => "get"
  match "db_action", :to => "events#db_action", :as => "db_action", :via => "post"

end
