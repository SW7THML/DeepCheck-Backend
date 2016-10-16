Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?

	scope = 'email,public_profile,user_photos'

  if Rails.env.production?
    # Production
    provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62', scope: scope
  else
    # Dev
    #provider :facebook, '550795318452539', 'd64fdd0894bb2c06956811e9b9b72ce1', scope: scope
    provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62', scope: scope
  end
end
