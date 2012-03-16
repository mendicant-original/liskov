class Task < ActiveRecord::Base
  belongs_to :course

  validates_presence_of   :course_id, :description
  validates_uniqueness_of :description, :scope => :course_id
end
