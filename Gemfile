source 'https://rubygems.org'

# rails
gem 'rails', '~>4.2.0'

# postgresql adapter
gem 'pg'

# preprocessors
gem 'sass-rails', '~> 5.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'uglifier', '>= 1.3.0'
gem 'slim-rails'
gem 'jbuilder', '~> 2.0'

# assets
gem 'jquery-rails'
gem 'semantic-ui-sass', github: 'doabit/semantic-ui-sass'
gem 'jquery-datetimepicker-rails'
gem 'dropzonejs-rails'
gem 'bxslider-rails', '~> 4.2', '>= 4.2.5.1'

# turbolinks
gem 'turbolinks'

# logic
gem 'devise'
gem 'cancancan'
gem 'rolify'
gem 'aasm'
gem 'paperclip', '~> 4.3.0'
gem 'mailboxer'
gem 'public_activity'
gem 'rails_admin', '~> 0.7.0'

# jobs
gem 'sidekiq'

# other
gem 'sdoc', '~> 0.4.0', group: :doc
gem 'annotate'
gem 'active_link_to'
gem 'cocoon', '~> 1.2.6'

# forum
gem 'forem', github: 'radar/forem', branch: 'rails4'
gem 'kaminari', '0.15.1'
gem 'celluloid', '0.16.0'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'

  gem 'net-ssh'
  gem 'quiet_assets'
  gem 'capistrano', '~> 3.4.0'
  gem 'capistrano-rvm'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-sidekiq'
  gem 'capistrano3-unicorn', require: false

  gem 'capybara', '~> 2.3.0'
  gem 'rspec-rails', '~> 3.0.0'
  gem 'rspec-mocks'
  gem 'factory_girl_rails', require: false
  gem 'database_cleaner'
  gem 'cucumber-rails', require: false
  gem 'selenium-webdriver'
  gem 'rack'
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'email_spec'
  gem 'delorean'
  gem 'mailcatcher'
end

group :production do
  gem 'unicorn'
end
