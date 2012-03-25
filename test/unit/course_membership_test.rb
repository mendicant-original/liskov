require "test_helper"
require "minitest/spec"

describe CourseMembership do
  it "has one study plan" do
    plan = StudyPlan.new
    membership = CourseMembership.new(study_plan: plan)
    membership.study_plan.must_equal plan
  end

  describe "adding a student" do
    before do
      @membership = CourseMembership.new(role: 'Student')
    end

    it "should not identify the student as an instructor" do
      @membership.has_role?(:instructor).must_equal false
    end

    it "should not identify the student as an mentor" do
      @membership.has_role?(:mentor).must_equal false
    end

    it "should identify the student as a student" do
      @membership.has_role?(:student).must_equal true
    end
  end

  describe "adding an instructor" do
    before do
      @membership = CourseMembership.new(role: 'Instructor')
    end

    it "should identify the instructor as an instructor" do
      @membership.has_role?(:instructor).must_equal true
    end

    it "should not identify the instructor as an mentor" do
      @membership.has_role?(:mentor).must_equal false
    end

    it "should not identify the instructor as a student" do
      @membership.has_role?(:student).must_equal false
    end
  end
end
