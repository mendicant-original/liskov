require "test_helper"
require "minitest/spec"

describe Course do

  before do
    @course = Course.create
  end

  describe "adding a student" do

    before do
      @person = Clubhouse::Client::Person.new('student')
      @cm = @course.course_memberships.build(person_github_nickname: 'student', role: 'Student')
    end

    it "should not identify the student as an instructor" do
      @course.instructor?(@person).must_equal false
    end

  end

  describe "adding an instructor" do

    before do
      @person = Clubhouse::Client::Person.new('instructor')
      @cm = @course.course_memberships.build(person_github_nickname: 'instructor', role: 'Instructor')
    end

    it "should identify the student as an instructor" do
      @course.instructor?(@person).must_equal true
    end

  end
end
