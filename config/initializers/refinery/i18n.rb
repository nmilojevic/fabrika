# encoding: utf-8

Refinery::I18n.configure do |config|
   config.default_locale = :rs

   config.current_locale = :rs

   config.default_frontend_locale = :rs

   config.frontend_locales = [:en, :rs]

  config.locales = {:en=>"English", :rs=>"Srpski"}
end
