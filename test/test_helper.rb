ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"

Clubhouse::Client.test_mode = true

def build_person(person, course = nil)
  PersonDecorator.new(FactoryGirl.build(person, course: course))
end

class ActiveSupport::TestCase
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  teardown { Capybara.reset_sessions! }

  def sign_in(person)
    visit root_url
    fill_in("Name", with: person.name)
    fill_in("Email", with: person.email)
    fill_in("Nickname", with: person.github_nickname)
    click_button "Sign In"
    assert_includes(page.body, "Welcome to Liskov")
  end
end
