class Course < ActiveRecord::Base
  has_many :discussions
  has_many :course_memberships
  has_many :tasks

  def participants
    @participants ||= course_memberships.map { |cm| cm.person }
  end
end
