class TasksController < ApplicationController
  before_filter :find_course

  def new
    @task = @course.tasks.build
  end

  def create
    task = @course.tasks.build(params[:task])
    task.save!
    redirect_to course_path(@course)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to course_path(task.course)
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end
end