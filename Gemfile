ruby ">=2.7.5"

# global source
source "https://rubygems.org"

source 'https://rubygems.org' do

  gem "dotenv"
  gem 'rails', '~> 7.0.0'
  gem 'rails-observers'

  group :assets do
    gem "sass-rails"
    gem "coffee-rails"
    gem "uglifier"
    gem 'sprockets'
    gem 'sprockets-rails', :require => 'sprockets/railtie'
  end

  platforms :ruby do
    gem 'mysql2'
    # gem 'pg', '>= 0.9.0'
    # gem 'sqlite3'
  end

  gem 'haml-rails', "~> 2.0.0"
  gem 'jquery-rails'
  gem 'will_paginate'
  gem "audited"
  gem 'inherited_resources', '~> 1.13.1'
  gem 'actionpack-xml_parser'
  gem 'devise'
  gem "devise-encryptable"
  gem 'rabl'
  gem 'state_machines'
  gem 'exception_notification'
  gem "font-awesome-rails"

  gem 'acts_as_list'
  gem 'dynamic_form'

  gem 'delayed_job', '~>4.1.10'
  gem 'delayed_job_active_record', '~>4.1.7'
  gem 'daemons'
  gem 'request_store'
  
  # https://github.com/ruby/net-imap/issues/16
  gem "net-http"
  gem "net-smtp"
  gem "net-imap"
  gem "uri"

  gem "rails-html-sanitizer", "~> 1.4.4"
  gem "loofah"
  
  # rails 7
  gem 'uglifier'
  
  # needet for ruby 2.7 support
  gem 'bigdecimal', '1.4.2'

  group :development do
    gem 'test-unit', '~> 3.0'
    gem 'debugger', :platform => :mri_19
  end

  group :development, :test do
    gem 'therubyracer'
    gem "rspec-rails"
    gem 'RedCloth', '>= 4.3.2'
  end

  group :test do
    gem "factory_girl_rails", "~> 4.0"

    gem "cucumber-rails", :require => false
    gem 'mocha', :require => false
    gem 'webrat'
    gem 'database_cleaner'
  end

end

source 'https://gemsrv.qutic.net/' do
  gem 'rundeck-ruby-client'
end
