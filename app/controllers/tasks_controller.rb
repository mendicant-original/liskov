class TasksController < ApplicationController
  def create
    task = Task.new(params[:task])
    task.save!
    redirect_to course_path(task.course)
  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to course_path(task.course)
  end
end
