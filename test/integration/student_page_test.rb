require "test_helper"

describe "Student Page Integration" do

  before do
    @course     = FactoryGirl.create(:webdev)
    @student    = build_person(:student, @course)

    sign_in @student

    click_link "Web Development"
    click_link "Student"
  end

  it "should display all of the course tasks on the student page" do
    @course.tasks.each do |t|
      within_task(t) do 
        assert_task_is_on_page(t)
        assert_task_is_incomplete(t)
      end
    end
  end


end

private

def within_task(task)
  within(:xpath, task_xpath(task)) do
    yield
  end
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

def task_incomplete?
  has_content?("Not complete")
end

def task_xpath(task)
  "//tr[@data-taskid='#{task.id}']"
end
