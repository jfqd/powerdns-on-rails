source 'https://rubygems.org' do

  gem "dotenv"
  gem 'rails', '~> 4.2.11.1'
  gem 'rails-observers'

  group :assets do
    gem 'sass-rails', '~> 4.0.5'
    gem 'coffee-rails'
    gem 'uglifier'
  end

  platforms :ruby do
    gem 'mysql2'
    # gem 'pg', '>= 0.9.0'
    # gem 'sqlite3'
  end

  gem 'haml-rails'
  gem 'jquery-rails'
  gem 'will_paginate', '~> 3.2.1'
  gem "audited-activerecord", "~> 4.2.2"
  gem 'inherited_resources', '1.9.0'
  gem 'devise', '~> 4.7.1'
  gem "devise-encryptable"
  gem 'rabl'
  gem 'state_machines'

  gem 'acts_as_list'
  gem 'dynamic_form'

  gem 'delayed_job', '~>4.1.8'
  gem 'delayed_job_active_record'
  gem 'daemons'
  gem 'request_store'

  group :development do
    gem 'test-unit', '~> 3.0'
    gem 'debugger', :platform => :mri_19
    #gem 'RedCloth', '>= 4.1.1'
  end

  group :development, :test do
    gem 'therubyracer'
    gem "rspec-rails"
    gem 'RedCloth', '>= 4.1.1'
  end

  group :test do
    gem "factory_girl_rails", "~> 4.0"

    gem "cucumber-rails", :require => false
    gem 'mocha', :require => false
    gem 'webrat'
    gem 'database_cleaner'
  end

end

source 'https://qsm02-gemsrv.qutic.net/' do
  gem 'rundeck-ruby-client', '~> 0.1.2'
end
