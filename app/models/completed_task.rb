class CompletedTask < ActiveRecord::Base
  belongs_to :course_membership
  belongs_to :task

  validates_presence_of :description
end
