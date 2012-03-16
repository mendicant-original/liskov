require "test_helper"

# describe "Manage tasks integration" do
#   it "creates a new task" do
#     visit root_path
#     click_link "Wev Dev"
#     click_link "Add Task"
#     fill_in("Description", with: "Community Service")
#     click_button "Create Task"
#     page.body.must_include "Community Service"
#   end
# end

class TasksTest < ActionDispatch::IntegrationTest
  fixtures :all

  test "creates a new task" do
    visit root_url
    fill_in("Name", with: "instructor")
    fill_in("Email", with: "instructor@mendicantuniversity.org")
    fill_in("Nickname", with: "instructor")
    click_button "Sign In"
    assert_includes(page.body, "Welcome to Liskov")

    click_link "Web Development"
    click_link "Add Task"
    fill_in("Description", with: "Community Service")
    click_button "Create Task"
    assert_includes(page.body, "Community Service")
  end
end