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

    @course.tasks.each do |t|
      assert_task_is_on_page page, t
    end
  end

end

private

def assert_task_is_on_page(page, task)
  includes_task_row?(page, task).must_equal true, "Could not find task '#{task.description}' on the page"
end

def includes_task_row?(page, task)
  page.has_xpath?("//tr[@data-taskid='#{task.id}']")
end
