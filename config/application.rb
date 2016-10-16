require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module DeepcheckBackend
	class Application < Rails::Application
		# Settings in config/environments/* take precedence over those specified here.
		# Application configuration should go into files in config/initializers
		# -- all .rb files in that directory are automatically loaded.

		if Rails.env.production?
			Rails.configuration.host_name = 'deepcheck.herokuapp.com'
		else
			Rails.configuration.host_name = '127.0.0.1:3000'
		end
		config.time_zone = 'Seoul'
		config.i18n.default_locale = :ko
	end
end
