class StudyPlansController < ApplicationController
  before_filter :find_course, :find_student

  def show
    @study_plan = StudyPlanDecorator.new(@student.study_plan)
  end

  def edit
    @study_plan = @student.study_plan
  end

  def update
    @student.study_plan.update_attribute(:content, params[:study_plan][:content])
    flash[:notice] = "Study plan updated."

    redirect_to(course_student_plan_path(@course, @student))
  end
end
