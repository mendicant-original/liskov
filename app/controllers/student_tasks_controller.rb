class StudentTasksController < ApplicationController
  before_filter :find_course, :find_student, :find_task

  def edit
  end

  def update
    status = params[:student_task][:status]
    result = @student_task.complete(status)

    if(result)
      url = course_student_path(@course, @student)
      redirect_to(url, notice: "Task completed")
    else
      url = @student_task.edit_url 
      redirect_to(url, alert: "Task was not completed")
    end
  end

  private

  def find_task
    @student_task = @student.tasks.find { |st| st.task_id == params[:task_id].to_i }
    not_found unless @student_task
  end

end
