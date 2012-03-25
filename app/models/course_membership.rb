class CourseMembership < ActiveRecord::Base
  ROLES = %w{Student Mentor Instructor}

  belongs_to :course

  has_many :completed_tasks

  validates_presence_of   :course_id, :role, :person_github_nickname
  validates_uniqueness_of :person_github_nickname, :scope => :course_id
  validate :person_permissions

  scope :for_person, lambda { |person| where(person_github_nickname: person.github_nickname) }

  def person
    @person ||= PersonDecorator.from_github(person_github_nickname)
  end

  def has_role?(has_role)
    has_role.to_s.capitalize == role.capitalize
  end

  def status_for(task)
    completed = get_completed(task) 
    completed ? completed.description : CompletedTask::NOT_COMPLETE
  end

  def complete_task(task, description)
    #TODO: is there a better way to do an upsert? - cg
    completed = get_completed(task) || completed_tasks.build(task_id: task.id)
    completed.description = description
    completed.save
  end

  private

  def get_completed(task)
    completed_tasks.where(task_id: task.id).first
  end

  def person_permissions
    if person.nil?
      errors.add(:person_github_nickname, "is not valid")
    elsif person.permissions['Liskov'].nil?
      errors.add(:person_github_nickname, "does not have access to Liskov")
    end
  end
end
