class Course < ActiveRecord::Base
  has_many :discussions
  has_many :course_memberships
  has_many :tasks

  def participants
    @participants ||= course_memberships.map { |cm| cm.person }
  end

  def membership_for(person)
    return nil unless person && person.github_nickname
    course_memberships.for_person(person).first
  end
end
