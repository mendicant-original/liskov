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
    "Not complete"
  end

  private

  def task
    @task
  end

end
