class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def tasks
    course_membership.course.tasks.map {|t| TaskDecorator.new(course_membership, t)}
  end

end
