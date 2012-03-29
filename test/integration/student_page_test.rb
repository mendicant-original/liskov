require "test_helper"

describe "Student Page Integration" do

  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)
    @instructor = build_person(:instructor, @course)
  end

  it "should display a read-only status for each course task" do
    sign_in @student

    click_link "Web Development"
    click_link "Student"

    @course.tasks.each do |t|
      within_task(t) do 
        assert_task_is_on_page(t)
        assert_task_is_incomplete(t)
        assert_complete_task_link_does_not_exist
      end
    end
  end

  it "should allow an instructor to complete a task" do
    sign_in @instructor

    click_link "Web Development"
    click_link "Student"

    task = @course.tasks.first

    within_task(task) do
      assert_complete_task_link_exists
      click_link "Mark as complete"
    end

    fill_in("Status", with: "Puzzlenode")
    click_button "Submit"

    within_task(task) do
      assert_task_has_status(task, "Puzzlenode")
    end
  end

end

private

def within_task(task)
  within(:xpath, task_xpath(task)) do
    yield
  end
end

def assert_complete_task_link_exists
  has_link?("Mark as complete").must_equal true, "The link to complete the task does not exist"
end

def assert_complete_task_link_does_not_exist
  has_link?("Mark as complete").must_equal false, "The link to complete the task should not exist"
end

def assert_task_has_status(task, status)
  has_content?(status).must_equal true, "Task '#{task.description}' does not have status '#{status}'"
end

def assert_task_is_incomplete(task)
  task_incomplete?.must_equal true, "Task '#{task.description}' is not marked as incomplete"
end

def assert_task_is_on_page(task)
  task_on_page?(task).must_equal true, "Could not find task '#{task.description}' on the page"
end

def task_on_page?(task)
  has_content?(task.description)
end

def task_on_page?(task)
  has_content?(task.description)
end

def task_incomplete?
  has_content?("Not complete")
end

def task_xpath(task)
  "//tr[@data-taskid='#{task.id}']"
end
