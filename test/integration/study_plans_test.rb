require "test_helper"

describe "Study plans Integration" do
  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)
    @instructor = build_person(:instructor, @course)
  end

  it "cannot be edited by students" do
    sign_in(@student)
    click_link "Web Development"
    click_link "Student"
    click_link "Study plan"
    page.body.wont_include "Edit plan"
  end

  it "can be edited by instructor" do
    sign_in(@instructor)
    click_link "Web Development"
    click_link "Student"
    click_link "Study plan"
    click_link "Edit plan"
    page.has_selector?("textarea#study_plan_content").must_equal true
  end

  it "parses Markdown" do
    sign_in(@student)
    click_link "Web Development"
    click_link "Student"
    click_link "Study plan"
    page.body.must_include "<h2>Study Plan</h2>"
  end
end
