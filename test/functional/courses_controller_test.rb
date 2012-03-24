require "test_helper"

describe CoursesController do
  before do
    @course   = FactoryGirl.create(:webdev)
    @student  = build_person(:student, @course)
    @controller.current_person = @student
  end

  it "lists participants in course page" do
    get(:show, id: @course.id)
    assigns(:participants).size.must_equal 1
    assigns(:participants).must_include @student
  end
end
