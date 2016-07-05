require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Projects
  class Application < Rails::Application

    config.autoload_paths += %W(#{config.root}/lib)


    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end
    config.fabrika_url = ENV['FABRIKA_URL'] || "http://fabrika-crossfit.herokuapp.com/"
    # config.action_controller.asset_host = "http://www.factorynis.com"#ENV['FABRIKA_URL'] || "http://fabrika-crossfit.herokuapp.com/"
    config.enabled_long_tasks = ENV['ENABLED_LONG_TASKS'] || "expire_members warn_members"

    config.active_job.queue_adapter = :delayed_job
    config.before_initialize do
      require 'refinery_patch'
      require 'restrict_refinery_to_refinery_users'
    end

    config.time_zone = "Europe/Belgrade"
    # config.active_record.default_timezone = "Europe/Belgrade"
    # # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
     config.i18n.default_locale = :rs

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    include Refinery::Engine
      after_inclusion do
        ::Refinery::ApplicationController.send :include, ::RefineryPatch
        ::Refinery::Blog::Admin::PostsController.send :include, ::RefineryPatch
        ::Refinery::AdminController.send :include, ::RefineryPatch   
        ::Refinery::AdminController.send :include, ::RestrictRefineryToRefineryUsers
        ::Refinery::AdminController.send :before_filter, :restrict_refinery_to_refinery_users
    end
  end
end
