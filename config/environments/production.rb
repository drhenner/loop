#require 'rack/ssl'
require 'rack/ssl-enforcer'

Hadean::Application.configure do
  # Settings specified here will take precedence over those in config/environment.rb

  config.middleware.use Rack::SslEnforcer, :only_hosts => 'secure.loopdeluxe.com'
  #config.middleware.use Rack::SSL
  #config.middleware.insert_before ActionDispatch::Cookies, Rack::SSL

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  config.cache_store = :dalli_store

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false
  config.action_mailer.default_url_options = { :host => 'loopdeluxe.heroku.com' }

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify


  config.after_initialize do
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::DatePicker)
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::FuturePicker)
    #Formtastic::SemanticFormBuilder.send(:include, Formtastic::YearPicker)

    ActiveMerchant::Billing::Base.mode = :test
    #::GATEWAY = ActiveMerchant::Billing::PaypalGateway.new(
    #  :login      => HADEAN_CONFIG['paypal']['login'],
    #  :password   => HADEAN_CONFIG['paypal']['password'],
    #  :signature  => HADEAN_CONFIG['paypal']['signature']
    #)

    ::GATEWAY = ActiveMerchant::Billing::AuthorizeNetGateway.new(
      :login    => HADEAN_CONFIG['authnet']['login'],
      :password => HADEAN_CONFIG['authnet']['password'],
      :test     => true
    )

    ::CIM_GATEWAY = ActiveMerchant::Billing::AuthorizeNetCimGateway.new(
      :login    => HADEAN_CONFIG['authnet']['login'],
      :password => HADEAN_CONFIG['authnet']['password'],
      :test     => true
    )

    #::GATEWAY = ActiveMerchant::Billing::BraintreeGateway.new(
    #  :login     => HADEAN_CONFIG['braintree']['login'],
    #  :password  => HADEAN_CONFIG['braintree']['password']
    #)
  end
end
