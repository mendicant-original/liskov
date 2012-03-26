class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def tasks
    course_membership.course.tasks.map(&:description)
  end

  def study_plan
    course_membership.study_plan || course_membership.create_study_plan
  end

  def to_param
    course_membership.person.to_param
  end
end
