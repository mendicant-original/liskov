class StudentTask
  NOT_COMPLETE = -1

  def self.build_for(course_membership)
    course_membership.course.tasks.map {|t| new(course_membership, t) }
  end

  def initialize(course_membership, task)
    @course_membership = course_membership
    @task = task
  end

  def course
    @course_membership.course
  end

  def task_id
    @task.id
  end

  def description
    @task.description
  end

  def status
    completed = get_completed_task
    completed ? completed.description : NOT_COMPLETE
  end

  def complete_task(description)
    #TODO: is there a better way to do an upsert? - cg
    completed = get_completed_task || completed_tasks.build(task_id: task_id)
    completed.description = description
    completed.save
  end

  private

  def completed_tasks
    @course_membership.completed_tasks
  end

  def get_completed_task
    completed_tasks.where(task_id: task_id).first
  end

end
