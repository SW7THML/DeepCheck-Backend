Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

  scope = 'email,public_profile,user_photos'

  if Rails.env.production?
    # Production
    provider :facebook, '535490729982998', '55f760d12b532a636b7a226c224825d4', {scope: scope, provider_ignores_state: true}
  else
    # Dev
    provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62', {scope: scope, provider_ignores_state: true}
  end
end
