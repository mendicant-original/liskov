require "test_helper"

describe "Participants Integration" do
  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)
  end

  describe "participant is a student" do
    it "links to student page" do
      sign_in(@student)
      click_link "Web Development"
      find_link("Student")["href"].must_equal course_student_path(@course, @student)
    end
  end
end
