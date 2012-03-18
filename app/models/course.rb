class Course < ActiveRecord::Base
  has_many :course_memberships 
  has_many :tasks

  def people
    @people ||= course_memberships.map {|cm| cm.person }
  end

  def instructor?(person)
    membership = course_memberships.for_person(person).first
    membership.instructor? if membership
  end

end
