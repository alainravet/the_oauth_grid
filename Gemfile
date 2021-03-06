require 'rbconfig'
HOST_OS = RbConfig::CONFIG['host_os']

source 'https://rubygems.org'

gem 'rails', '3.2.6'

gem 'omniauth', '~> 1.1.0'
gem 'omniauth-twitter'
gem 'omniauth-facebook'
gem 'omniauth-linkedin'

gem 'twitter', '~> 2.5.0'
gem "koala",   '~> 1.5.0'
gem "linkedin",'~> 0.3.7'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
gem "haml-rails"

gem 'sqlite3'

gem 'json'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

guard_notifications = true
group :development do
  case HOST_OS
  when /darwin/i
    gem 'rb-fsevent'
    gem 'ruby_gntp' if guard_notifications
  when /linux/i
    gem 'libnotify'
    gem 'rb-inotify'
  when /mswin|windows/i
    gem 'rb-fchange'
    gem 'win32console'
    gem 'rb-notifu' if guard_notifications
  end
end

group :development do
  gem "guard-livereload"
  gem "yajl-ruby"
  gem "rack-livereload"
  gem "guard-bundler"
  gem "guard-rspec"
end

gem "rspec-rails", :group => [:development, :test]
gem "sqlite3", :group => [:development, :test]
group :assets do
  gem "twitter-bootstrap-rails"
  gem "therubyracer"
end

gem "simple_form"