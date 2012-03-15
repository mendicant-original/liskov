class CoursesController < ApplicationController
  def show
    @course  = CourseDecorator.find(params[:id])
    @members = @course.course_memberships
  end
end
