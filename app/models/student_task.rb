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

  def student
    @course_membership.person
  end

  def complete?
    status != NOT_COMPLETE
  end

  def status
    completed_task ? completed_task.description : NOT_COMPLETE
  end

  def complete(status)
    completed = completed_tasks.find_or_create_by_task_id(task_id: task_id)
    completed.description = status
    completed.save
  end

  private

  def completed_tasks
    @course_membership.completed_tasks
  end

  def completed_task
    completed_tasks.where(task_id: task_id).first
  end

end
