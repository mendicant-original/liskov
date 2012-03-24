require "test_helper"

describe "Student Page Integration" do

  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)
  end

  it "should display all of the course tasks on the student page" do
    sign_in @student
    click_link "Web Development"
    click_link "Student"

    page.body.must_include "Community Service"
    page.body.must_include "Personal Project"
    page.body.must_include "Challenge"
  end
end
