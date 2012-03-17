class CoursesController < ApplicationController
  def show
    @course         = CourseDecorator.find(params[:id])
    @is_instructor  = @course.instructor?(current_person)
    @members        = @course.course_memberships
    @tasks          = @course.tasks
  end
end
