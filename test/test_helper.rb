ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"

Clubhouse::Client.test_mode = true

def clubhouse_person(github_nickname)
  # FIXME: duplicates code from ApplicationController
  PersonDecorator.new(Clubhouse::Client::Person.new(github_nickname))
end

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  setup    { Factory(:instructor) }
  teardown { Capybara.reset_sessions! }

  def sign_in_as_instructor
    sign_in clubhouse_person('instructor')
  end

  def sign_in_as_student
    sign_in clubhouse_person('student')
  end

  def sign_in(person)
    visit root_url
    fill_in("Name", with: person.name)
    fill_in("Email", with: person.email)
    fill_in("Nickname", with: person.github_nickname)
    click_button "Sign In"
    assert_includes(page.body, "Welcome to Liskov")
  end
end
