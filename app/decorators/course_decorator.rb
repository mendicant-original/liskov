class CourseDecorator < ApplicationDecorator
  decorates :course

  def description
    #TODO process with markdown
    course.description
  end
end
