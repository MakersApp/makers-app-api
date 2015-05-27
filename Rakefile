# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Rails.application.load_tasks

require 'rspec/core/rake_task'
require 'rubocop/rake_task'

if ENV['RAILS_ENV'] == "test"
  RuboCop::RakeTask.new :cop
  RSpec::Core::RakeTask.new :spec
end

task default: [:cop, :spec]
