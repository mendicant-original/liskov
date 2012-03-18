require "test_helper"

class TasksTest < ActionDispatch::IntegrationTest

  setup { Factory(:instructor) }

  test "an instructor can create a new course task" do
    sign_in_as_instructor

    click_link "Web Development"
    click_link "Add Task"
    fill_in("Description", with: "Community Service")
    click_button "Create Task"
    assert_includes(page.body, "Community Service")
  end

  test "a student can only view course tasks" do
    sign_in_as_student

    click_link "Web Development"
    assert_not_includes(page.body, "Add Task")
  end
end
