class CompletedTask < ActiveRecord::Base
  NOT_COMPLETE = -1

  belongs_to :course_membership
  belongs_to :task

  validates_presence_of :description
end
