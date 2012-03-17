require "test_helper"

class TasksTest < ActionDispatch::IntegrationTest
  fixtures :all

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

  def sign_in_as_instructor
    sign_in(Clubhouse::Client::Person.new('instructor'))
  end

  def sign_in_as_student
    sign_in(Clubhouse::Client::Person.new('student'))
  end

  def sign_in(person)
    visit root_url
    fill_in("Name", with: person.name)
    fill_in("Email", with: person.email)
    fill_in("Nickname", with: person.github_nickname) 
    click_button "Sign In"
    assert_includes(page.body, "Welcome to Liskov")
  end
end
