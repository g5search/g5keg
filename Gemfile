source "https://rubygems.org"
ruby "1.9.3"

gem 'rails', '3.1.12'
gem 'haml', '3.1.1'
gem 'sass'
gem 'formtastic', '1.2.3'
gem 'inherited_resources', '1.2.2'
gem 'activeadmin'
gem 'meta_search', '>= 1.1.0.pre'
gem 'paperclip'
gem 'aws-sdk'
gem 'aws-s3'
gem 'unicorn'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', " ~> 3.1.0"
  gem 'coffee-rails', " ~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3', group: [:development, :test]
gem 'pg', group: :production

# Auth
gem 'oauth'
gem 'ruby-openid', :require => 'openid'
gem 'ruby-openid-apps-discovery',
  :git => 'git://github.com/skrat/ruby-openid-apps-discovery.git',
  :require => 'gapps_openid'
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
