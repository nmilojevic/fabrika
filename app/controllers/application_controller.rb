class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :set_locale
  after_filter :cors_set_access_control_headers
  skip_before_filter :authenticate_user!, :only => [:route_options]
  before_action :prepare_meta_tags, if: "request.get?"

  def after_sign_in_path_for(resource)
    schedule_path
  end

  def prepare_meta_tags(options={})
    site_name   = "Factory Niš"
    title       = [controller_name, action_name].join(" ")
    description = "Factory Niš Forging Elite Fitness"
    image       = options[:image] || "your-default-image-url"
    icon        = '/favicon.png'
    current_url = request.url

    # Let's prepare a nice set of defaults
    defaults = {
      site:        site_name,
      title:       title,
      image:       image,
      description: description,
      keywords:    %w[fitness factory trening fitnes teretana fabrikanti joga fabrika bootcamp weightlifting poweryoga healt gym strong intensity],
      twitter: {
        site_name: site_name,
        site: '@fabrika_018',
        card: 'summary',
        description: description,
        image: image
      },
      og: {
        url: current_url,
        site_name: site_name,
        title: title,
        image: image,
        description: description,
        type: 'website'
      }
    }

    options.reverse_merge!(defaults)

    set_meta_tags options
  end

  def route_options
    cors_preflight_check
  end

  private

    def cors_set_access_control_headers
      response.headers['Access-Control-Allow-Origin'] = '*'
      response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
      response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email'
      response.headers['Access-Control-Request-Method'] = '*'
      response.headers['Access-Control-Max-Age'] = "1728000"
    end

    def cors_preflight_check
      if request.method == 'OPTIONS'
        request.headers['Access-Control-Allow-Origin'] = '*'
        request.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
        request.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token, Auth-Token, Email'
        request.headers['Access-Control-Request-Method'] = '*'
        request.headers['Access-Control-Max-Age'] = '1728000'  
        render :text => '', :content_type => 'text/plain'
      end
    end
  def set_locale
    @locale = params[:locale] || I18n.default_locale
    I18n.locale = @locale
  end
  
end
