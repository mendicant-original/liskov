class StudentTaskDecorator < ApplicationDecorator
  decorates :student_task

  def status
    status = student_task.status
    status == CompletedTask::NOT_COMPLETE ? "Not complete" : status
  end

  def complete_task_link(current_person)
    if(current_person.has_role?(:instructor, student_task.course))
      h.link_to "Mark as complete", "/" 
    end
  end

end
