require "test_helper"

describe "Student Page Integration" do

  before do
    @course     = FactoryGirl.create(:webdev)
    @instructor = build_person(:instructor, @course)
    @student    = build_person(:student, @course)
  end

  it "should display all of the course tasks on the student page" do
    visit course_student_path @course, @student

    page.body.must_include "Community Service"
    page.body.must_include "Personal Project"
    page.body.must_include "Challenge"
  end
end
