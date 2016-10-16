Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer unless Rails.env.production?
  provider :facebook, '1038966506229104', 'd218f6844561d97f593f0f8877a73d62'
  #provider :facebook, '535490729982998', '55f760d12b532a636b7a226c224825d4'
end
