# Configure Spree Preferences
#
# Note: Initializing preferences available within the Admin will overwrite any changes that were made through the user interface when you restart.
#       If you would like users to be able to update a setting with the Admin it should NOT be set here.
#
# In order to initialize a setting do:
# config.setting_name = 'new value'
Spree.config do |config|
  # Example:
  # Uncomment to stop tracking inventory levels in the application
  # config.track_inventory_levels = false
  config.currency = 'EUR'
  config.default_country_id = 1
  config.currency_decimal_mark = ','
  config.currency_thousands_separator = ''
  config.currency_symbol_position = 'after'

end

Spree.user_class = "Spree::User"


# RAILS CONFIG FOR SPREE
rails_config = Rails.application.config.spree

# PROMOTIONS

rails_config.promotions.actions = [Spree::Promotion::Actions::CreateAdjustment]

# CALCULATORS

rails_config.calculators.promotion_actions_create_item_adjustments = [Spree::Calculator::FlatRate]
rails_config.calculators.promotion_actions_create_adjustments = [Spree::Calculator::FlatRate]
rails_config.calculators.shipping_methods = [Spree::Calculator::Shipping::FlatRate]
