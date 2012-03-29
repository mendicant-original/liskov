class CourseMembership < ActiveRecord::Base
  ROLES = %w{Student Mentor Instructor}

  belongs_to  :course
  has_one     :study_plan

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

  def student_tasks
    StudentTask.build_for(self)
  end

  private

  def person_permissions
    unless person && person.can_access_liskov?
      errors.add(:person_github_nickname, "needs Clubhouse ID and access to Liskov")
    end
  end
end
