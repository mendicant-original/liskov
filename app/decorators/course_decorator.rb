class CourseDecorator < ApplicationDecorator
  decorates :course

  def has_role?(role, person)
    course.has_role?(role, person)
  end

  def description
    #TODO process with markdown
    course.description
  end
end
