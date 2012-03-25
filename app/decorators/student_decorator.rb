class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def name
    course_membership.person.name
  end

  def tasks
    course_membership.course.tasks.map {|t| TaskDecorator.new(course_membership, t)}
  end

end
