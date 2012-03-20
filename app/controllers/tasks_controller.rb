class TasksController < ApplicationController
  before_filter :find_course, :check_permission

  def new
    @task = @course.tasks.build
  end

  def create
    task = @course.tasks.build(params[:task])

    if task.save
      redirect_to(@course, notice: "Task created")
    else
      redirect_to new_course_task_path(@course)
    end
  end

  def destroy
    task = Task.find(params[:id])

    if task.destroy
      flash[:notice] = "Task removed successfully"
    else
      flash[:alert] = "Sorry, there was an error remove the task from the course"
    end
    redirect_to @course
  end

  private

  def check_permission
    unless current_person.has_role?(:instructor, @course)
      redirect_to(@course, alert: "Unauthorized access")
    end
  end

  def find_course
    @course = Course.find(params[:course_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_url, alert: "Couldn't find course")
  end
end
