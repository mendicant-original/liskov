class CoursesController < ApplicationController
  def show
    @course         = CourseDecorator.find(params[:id])
    @members        = @course.course_memberships
    @tasks          = @course.tasks
  end
end
