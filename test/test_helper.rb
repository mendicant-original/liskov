ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "minitest/spec"
require "support/spec"

Clubhouse::Client.test_mode = true
DatabaseCleaner.strategy    = :transaction

def build_person(person, course = nil)
  PersonDecorator.new(FactoryGirl.build(person, course: course))
end
