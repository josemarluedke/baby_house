source 'https://rubygems.org'

gem 'rails', '3.2.16'

# Database
gem 'pg'
gem 'foreigner'

# Improvements
gem 'inherited_resources'

# Authentication
gem 'devise', '~> 2.1.2'
gem 'cancan', '~> 1.6.8'

# Server
gem 'thin'

# Frontend stuff
gem 'jquery-rails', '~> 2.1.4'
gem 'slim-rails'
gem 'prettyphoto-rails', '~> 0.2.0'
gem 'initjs', '~> 1.0.0'

# Tools
gem 'simple_form', '~> 2.0.4'
gem 'friendly_id', '~> 4.0.9'
gem 'auto_html', '~> 1.6.0'
gem 'mail_form', '~> 1.4.1'
gem 'tinymce-rails', '~> 3.5.8'
gem 'tinymce-rails-imageupload', '~> 3.5.6.3'
gem 'sendgrid'
gem 'feedzirra'
gem 'rubyzip', '~> 1.1.0'
gem 'sidekiq', '~> 2.17.2'

# Administration
gem 'rails_admin', '~> 0.2.0'
gem 'rails_admin_import', '~> 0.1.8'

# Images
gem 'carrierwave', '~> 0.6.2'
gem 'rmagick'
#gem 'carrierwave-postgresql'
#gem 'postgresql_lo_streamer', github: 'diogob/postgresql_lo_streamer'

gem 'tilt', '~> 1.3.0'
group :assets do
  gem 'sass-rails', '~> 3.2.6'
  gem 'coffee-rails', '~> 3.2.2'
  gem 'compass-rails', '~> 1.0.3'
  gem 'bootstrap-sass'
  gem 'compass-960-plugin'
  gem 'uglifier', '>= 1.0.3'
end

group :production do
  gem 'execjs'
  gem 'therubyracer', :platform => :ruby
end

group :development, :test do
  gem 'rspec-rails', '>= 2.11.0'
  gem 'shoulda-matchers'
  gem 'machinist', '>= 2.0'
  gem 'ffaker'
  gem 'database_cleaner'
  gem 'pry'
  gem 'awesome_print'
  gem 'simplecov', '~> 0.8.2', :require => false
end
