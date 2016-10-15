Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  if Rails.env.production?
    # Production
    provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62'
  else
    # Dev
    provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62'
  end
end