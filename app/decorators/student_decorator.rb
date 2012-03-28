class StudentDecorator < ApplicationDecorator
  decorates :course_membership

  def name
    course_membership.person.name
  end

  def tasks
    course_membership.student_tasks.map {|st| StudentTaskDecorator.new(st)}
  end

  def study_plan
    StudyPlan.find_or_create_by_course_membership_id(course_membership)
  end

  def to_param
    course_membership.person.to_param
  end

  private 

  def course
    course_membership.course
  end
end
