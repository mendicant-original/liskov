class Course < ActiveRecord::Base
  has_many :course_memberships 
  has_many :tasks

  def people
    @people ||= course_memberships.map {|cm| cm.person }
  end

end
