require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UltimateCycle
  class Application < Rails::Application

    config.to_prepare do

      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_extension.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      address: 'smtp.mandrillapp.com',
      port: 587,
      domain: 'ultimate-cycle-distribution.com',
      user_name: ENV['MANDRILL_USERNAME'] || Rails.application.secrets.mandrill_username,
      password: ENV['MANDRILL_APIKEY'] || Rails.application.secrets.mandrill_key,
      authentication: 'login',
      enable_starttls_auto: true
    }

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :fr


    config.after_initialize do
      config.spree.promotions.rules = [Spree::Promotion::Rules::ItemTotal, Spree::Promotion::Rules::Product, Spree::Promotion::Rules::User]
    end

    config.active_job.queue_adapter = :delayed_job
  end
end
