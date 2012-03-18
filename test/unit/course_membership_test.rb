require "test_helper"
require "minitest/spec"

describe CourseMembership do

  describe "adding a student" do
    before do
      @membership = CourseMembership.new(role: 'Student')
    end

    it "should not identify the student as an instructor" do
      @membership.instructor?.must_equal false
    end
  end

  describe "adding an instructor" do
    before do
      @membership = CourseMembership.new(role: 'Instructor')
    end

    it "should not identify the student as an instructor" do
      @membership.instructor?.must_equal true
    end
  end
end

