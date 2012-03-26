require "test_helper"

describe StudyPlansController do
  before do
    @course   = FactoryGirl.create(:webdev)
    @student  = build_person(:student, @course)
    @controller.current_person = @student
  end

  it "automatically creates study plan on #show" do
    get(:show, course_id: @course.id, student_id: @student.github_nickname)
    assigns(:study_plan).wont_equal nil
  end
end
