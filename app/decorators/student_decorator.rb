class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def name
    course_membership.person.name
  end

  def tasks
    course_membership.student_tasks.map {|st| StudentTaskDecorator.new(st)}
  end

  def study_plan
    course_membership.study_plan || course_membership.create_study_plan
  end

  def to_param
    course_membership.person.to_param
  end

  private 

  def course
    course_membership.course
  end
end
