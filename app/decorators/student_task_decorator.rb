class StudentTaskDecorator < ApplicationDecorator
  decorates :student_task

  def status
    student_task.complete? ? student_task.status : "Not complete"
  end

  def completed_status_css
    student_task.complete? ? "complete" : "not-complete"
  end

  def edit_link(current_person)
    if(current_person.has_role?(:instructor, student_task.course))
      h.link_to "Mark as complete", edit_url
    end
  end

  def edit_url
    course  = student_task.course
    student = student_task.student
    task_id = student_task.task_id
    h.edit_course_student_student_tasks_path(course, student, task_id: task_id)
  end

  def update_url
    course  = student_task.course
    student = student_task.student
    task_id = student_task.task_id
    h.course_student_student_tasks_path(course, student, task_id: task_id)
  end

end
