source 'https://rubygems.org'

gem 'rails', '3.2.13'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'sqlite3'

gem 'haml-rails'

gem 'devise',           '~> 2.2.3'
gem 'cancan',  '~> 1.6.8'

gem "active_model_serializers", "~> 0.7.0"
gem 'squeel',        '~> 1.0.18'

gem 'jquery-rails'
gem 'jquery-ui-rails'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'zurb-foundation'
  #gem 'bootstrap-sass', '~> 2.3.1.0'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'execjs',              '~> 1.4.0'

  gem 'therubyracer'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'rb-readline'
  # Better documentation
  gem 'tomdoc',  '~> 0.2.5',  :require => false

  # Testing emails
  gem 'mailcatcher',  '~> 0.5.10',  :require => false

  # Deployment
  gem 'capistrano',      '~> 2.14.1',  :require => false
  gem 'capistrano-ext',  '~> 1.2.1',   :require => false
  gem 'rvm-capistrano'

  # Helpful Rails Generators
  gem 'nifty-generators',  '~> 0.4.6',  :require => false

  # Better error reports and logs
  gem 'meta_request',       '~> 0.2.1'
  gem 'quiet_assets',       '~> 1.0.1'
  gem 'better_errors',      '~> 0.3.2'
  gem 'binding_of_caller',  '~> 0.7.1'
  gem 'angularjs-rails', :git => "git://github.com/hiravgandhi/angularjs-rails.git"
end

group :development, :test do
  # Automatic testing
  gem 'rb-inotify',        '~> 0.8.8'
  gem 'guard',             '~> 1.6.2'
  gem 'guard-spork',       '~> 1.4.1'
  gem 'guard-rspec',       '~> 2.3.3'
  gem 'guard-sass',        '~> 1.0.1', :require => false
  gem 'guard-livereload',  '~> 1.1.3'

  # Placed here so generators work
  gem 'rspec-rails',  '~> 2.12.2'

  # Opening webpages during tests
  gem 'launchy', '~> 2.1.2'

  # Testing Javascript
  gem 'jasmine',  '~> 1.1.2'
  gem 'jasmine-headless-webkit', '~> 0.8.4'

  # Debugging Tools
  gem 'pry-rails',     '~> 0.2.2'
  gem 'pry-coolline',  '~> 0.2.1'

  #mucking round with the db
  gem 'forgery'
end

group :test do
  # Core Testing
  gem 'cucumber-rails', :require => false
  gem 'capybara',         '~> 2.0.2'
  gem 'capybara-webkit',  '~> 0.14.0'

  # Test Helpers
  gem 'database_cleaner',    '~> 0.9.1'
  gem 'timecop',             '~> 0.5.9'
  gem 'steak',               '~> 2.0.0'
  gem 'webrat',              '~> 0.7.3'
  gem 'email_spec',          '~> 1.4.0'
  gem 'factory_girl_rails',  '~> 4.1.0'
  gem 'shoulda',             '~> 3.3.2'

  # Test coverage
  gem 'simplecov',  '~> 0.7.1'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
