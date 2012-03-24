class CoursesController < ApplicationController
  def show
    @course         = CourseDecorator.find(params[:id])
    @participants   = @course.participants
    @tasks          = @course.tasks
  end
end
