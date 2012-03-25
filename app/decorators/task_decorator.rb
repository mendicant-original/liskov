class TaskDecorator

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

  private

  def task
    @task
  end

  def participant
    @participant
  end

end
