class Task < ActiveRecord::Base
  belongs_to :course

  validates_presence_of :description
end
