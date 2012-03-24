require "support/integration"

module Support
  class RailsSpec < MiniTest::Spec
    include Rails.application.routes.url_helpers

    before do
      DatabaseCleaner.start
    end

    after do
      DatabaseCleaner.clean
    end
  end

  class IntegrationSpec < RailsSpec
    include Capybara::DSL
    include Integration

    before do
      DatabaseCleaner.clean_with(:truncation)
    end

    after do
      Capybara.reset_sessions!
    end
  end

  class ControllerSpec < RailsSpec
    include ActiveSupport::Testing::SetupAndTeardown

    alias :method_name :__name__ if defined? :__name__

    include ActionController::TestCase::Behavior

    before { @routes = Rails.application.routes }
  end

  MiniTest::Spec.register_spec_type(/Integration$/i, Support::IntegrationSpec)
  MiniTest::Spec.register_spec_type(/Controller$/i, Support::ControllerSpec)
end
