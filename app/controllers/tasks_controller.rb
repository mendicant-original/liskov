class TasksController < ApplicationController
  before_filter :find_course

  def new
    @task = @course.tasks.build
  end

  def create
    task = @course.tasks.build(params[:task])

    if task.save
      redirect_to @course, flash: { success: "Task created" }
    else
      redirect_to new_course_task_path(@course)
    end
  end

  def destroy
    task = Task.find(params[:id])

    if task.destroy
      flash[:success] = "Task removed successfully" 
    else
      flash[:error] = "Sorry, there was an error remove the task from the course"
    end
    redirect_to @course 
  end

  private

  def find_course
    @course = Course.find(params[:course_id])
  end

end
