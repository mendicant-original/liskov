module Support
  module Integration
    def sign_in(person)
      visit root_url(host: "test.host")
      fill_in("Name", with: person.name)
      fill_in("Email", with: person.email)
      fill_in("Nickname", with: person.github_nickname)
      click_button "Sign In"
      page.body.must_include("Welcome to Liskov")
    end
  end

  class IntegrationSpec < MiniTest::Spec
    include Rails.application.routes.url_helpers
    include Capybara::DSL
    include Integration

    after { Capybara.reset_sessions! }
  end

  class ControllerSpec < MiniTest::Spec
    include Rails.application.routes.url_helpers
    include ActiveSupport::Testing::SetupAndTeardown

    alias :method_name :__name__ if defined? :__name__

    include ActionController::TestCase::Behavior

    before { @routes = Rails.application.routes }
  end
end

MiniTest::Spec.register_spec_type(/Integration$/, Support::IntegrationSpec)
MiniTest::Spec.register_spec_type(/Controller$/, Support::ControllerSpec)
