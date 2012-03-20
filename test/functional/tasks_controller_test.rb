require "test_helper"

describe TasksController do
  before do
    @course = FactoryGirl.create(:webdev)
    @controller.current_person = build_person(:instructor, @course)
  end

  it "#new is not allowed to students" do
    @controller.current_person = build_person(:student)

    get(:new, course_id: @course.id)
    response.redirect?.must_equal true
    flash[:alert].must_equal "Unauthorized access"
  end

  it "#new is allowed to instructors" do
    get(:new, course_id: @course.id)
    response.success?.must_equal true
  end

  it "redirects to root if can't find course" do
    get(:new, course_id: 'ohai!')
    response.redirect?.must_equal true
    flash[:alert].must_equal "Couldn't find course"
  end
end
