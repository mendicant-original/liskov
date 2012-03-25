require "test_helper"

describe StudyPlan do
  before do
    @plan = StudyPlan.new
  end

  it "has content" do
    @plan.content = "foo"
    @plan.content.must_equal "foo"
  end

  it "references course membership" do
    @plan.course_membership_id = 1
    @plan.course_membership_id.must_equal 1
  end
end
