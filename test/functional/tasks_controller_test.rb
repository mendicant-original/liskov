require "test_helper"

class TasksControllerTest < ActionController::TestCase

  def setup
    cm = Factory(:instructor)
    @course = cm.course
    @controller.current_person = clubhouse_person("instructor")
  end

  test "#new is not allowed to students" do
    @controller.current_person = clubhouse_person("student")

    get(:new, course_id: @course.id)
    assert_redirected_to(@course)
    assert flash[:alert]
  end

  test "#new is allowed to instructors" do
    get(:new, course_id: @course.id)
    assert_template "new"
  end

  test "redirects to root if can't find course" do
    get(:new, course_id: 'ohai!')
    assert_redirected_to(root_url)
    assert flash[:alert]
  end
end
