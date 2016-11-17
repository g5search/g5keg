source "https://rubygems.org"
ruby "1.9.3"

gem 'rails', '3.2.18'
gem 'dotenv-rails'
gem 'haml-rails'
gem 'sass'
gem "activeadmin", "0.6.0"
gem 'meta_search', '>= 1.1.0.pre'
gem 'paperclip'
gem 'aws-sdk'
gem 'aws-s3'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails', '< 3.0.0'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production

# Auth
gem 'oauth'
gem 'ruby-openid', :require => 'openid'
gem 'ruby-openid-apps-discovery', :require => 'gapps_openid'
gem 'rack-openid', :require => 'rack/openid'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger (ruby-debug for Ruby 1.8.7+, ruby-debug19 for Ruby 1.9.2+)
# gem 'ruby-debug'
# gem 'ruby-debug19', :require => 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
group :test, :development do
  gem "rspec-rails"
  gem "factory_girl_rails", "1.1.beta1"
end
