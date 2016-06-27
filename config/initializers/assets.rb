# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'
Rails.application.config.assets.precompile += %w( dhtmlxscheduler.css )
Rails.application.config.assets.precompile += %w( dhtmlxscheduler_responsive.css )
Rails.application.config.assets.precompile += %w( dhtmlxscheduler_responsive.js )
Rails.application.config.assets.precompile += %w( dhtmlxscheduler.js )
Rails.application.config.assets.precompile += %w( dhtmlxmenu.css )
Rails.application.config.assets.precompile += %w( dhtmlxmenu.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_recurring.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_quick_info.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_readonly.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_key_nav.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_expand.js )
Rails.application.config.assets.precompile += %w( ext/dhtmlxscheduler_tooltip.js )
Rails.application.config.assets.precompile += %w( locale/locale_sr.js )
Rails.application.config.assets.precompile += %w( datatables.js )
# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.

