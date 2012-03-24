class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def tasks
    course_membership.course.tasks.map(&:description)
  end

end
