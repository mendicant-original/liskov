class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def name
    course_membership.person.name
  end

  def tasks
    course_membership.course.tasks.map {|t| TaskDecorator.new(course_membership, t)}
  end

  def study_plan
    course_membership.study_plan || course_membership.create_study_plan
  end

  def to_param
    course_membership.person.to_param
  end
end
