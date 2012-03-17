class TasksController < ApplicationController
  before_filter :find_course

  def new
    @task = @course.tasks.build
  end

  def create
    task = @course.tasks.build(params[:task])

    if task.save
      redirect_to course_path(@course)
    else
      flash[:error] = "Sorry, there was an error adding the task to the course"
    end
  end

  def destroy
    task = Task.find(params[:id])

    if task.destroy
      redirect_to course_path(task.course)
    else
      flash[:error] = "Sorry, there was an error remove the task from the course"
    end
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end
end
