require "test_helper"

describe StudyPlansController do
  before do
    @course   = FactoryGirl.create(:webdev)
    @student  = build_person(:student, @course)
    @controller.current_person = @student
  end

  def study_plan_params(params = {})
    { course_id: @course.id,
      student_id: @student.github_nickname
    }.merge(params)
  end

  it "automatically creates study plan on #show" do
    get(:show, study_plan_params)
    assigns(:study_plan).wont_equal nil
  end

  it "updates study plan" do
    put(:update, study_plan_params(study_plan: { content: "New plan" }))
    plan = StudyPlan.last

    plan.content.must_equal "New plan"
    flash[:notice].must_equal "Study plan updated."
    response.redirect?.must_equal true
  end
end
