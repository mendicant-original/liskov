class TaskDecorator < ApplicationDecorator

  def initialize(participant, task)
    @participant = participant
    @task = task
  end

  def id
    task.id
  end

  def description
    task.description
  end

  def status
    status = participant.status_for(task)
    status == CompletedTask::NOT_COMPLETE ? "Not complete" : status
  end

  def complete_task_link(current_person)
    if(current_person.has_role?(:instructor, course))
      h.link_to "Mark as complete", "/"
    end
  end

  private

  def task
    @task
  end

  def course
    participant.course
  end

  def participant
    @participant
  end

end
