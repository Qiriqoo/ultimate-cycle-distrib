gateway = Spree::Gateway::BraintreeGateway.where(name: 'Carte de Credit', description: 'Paiement a travers Braintree', auto_capture: true).first_or_create

gateway.preferences = {
  environment: ENV['BRAINTREE_ENVIRONMENT'] || Rails.application.secrets.braintree_environment,
  merchant_id: ENV['BRAINTREE_MERCHANT_ID'] || Rails.application.secrets.braintree_merchant_id,
  public_key: ENV['BRAINTREE_PUBLIC_KEY'] || Rails.application.secrets.braintree_public_key,
  private_key: ENV['BRAINTREE_PRIVATE_KEY'] || Rails.application.secrets.braintree_private_key,
  client_side_encryption_key: ENV['BRAINTREE_CLIENT_SIDE_KEY'] || Rails.application.secrets.braintree_client_side_key
}

gateway.save!
