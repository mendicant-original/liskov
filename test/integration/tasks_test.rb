require "test_helper"

describe "Tasks Integration" do

  before do
    @course     = FactoryGirl.create(:webdev)
    @instructor = build_person(:instructor, @course)
    @student    = build_person(:student, @course)
  end

  it "an instructor can create a new course task" do
    sign_in(@instructor)

    click_link "Web Development"
    click_link "Add Task"
    fill_in("Description", with: "A new course task")
    click_button "Create Task"
    page.body.must_include("A new course task")
  end

  it "a student can only view course tasks" do
    sign_in(@student)

    click_link "Web Development"
    page.body.wont_include("Add Task")
  end
end
