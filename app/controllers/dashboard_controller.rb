class DashboardController < ApplicationController
  def index
    @course = Course.find_by_name("Web Development")
  end
end
