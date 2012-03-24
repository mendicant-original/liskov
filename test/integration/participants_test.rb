require "test_helper"

describe "Participants Integration" do
  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)
    @instructor = build_person(:instructor, @course)

    sign_in(@student)
    click_link "Web Development"
  end

  it "links student to her page in the course" do
    find_link("Student")["href"].must_equal course_student_path(@course, @student)
  end

  it "links instructor to his community page" do
    find_link("Instructor")["href"].must_equal "http://community.mendicantuniversity.org/people/instructor"
  end
end
