class CoursesController < ApplicationController
  def show
    @course = CourseDecorator.find(params[:id])
  end
end
