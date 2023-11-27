# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :developer unless Rails.env.production?
    provider :steam, '2C9ECEC9C6837B5C3981B38CD12F8C1D'
  end
  