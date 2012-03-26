class StudyPlansController < ApplicationController
  before_filter :find_course, :find_student

  def show
    @study_plan = @student.study_plan
  end
end
