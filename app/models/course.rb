class Course < ActiveRecord::Base
  has_many :discussions
end
