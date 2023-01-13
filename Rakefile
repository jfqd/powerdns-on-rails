# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)
require 'rake'

require 'dotenv'
# https://github.com/bkeepers/dotenv/issues/19
ENV["RAILS_ENV"] ||= ENV["RACK_ENV"] || "production"
Dotenv.load ".env.#{ENV["RAILS_ENV"]}", '.env'

PowerdnsOnRails::Application.load_tasks
