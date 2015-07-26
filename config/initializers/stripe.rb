Rails.configuration.stripe = {
    :publishable_key => Rails.application.secrets.stripe_publishable_key,
    :secret_key      => Rails.application.secrets.stripe_secret_key,
    :client_key 	 => Rails.application.secrets.stripe_connect_client_id
}

Stripe.api_key = Rails.application.secrets.stripe_secret_key