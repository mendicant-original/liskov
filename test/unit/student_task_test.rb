require "test_helper"
require "minitest/spec"

describe StudentTask do

  before do
    course             = FactoryGirl.create(:webdev)
    student            = FactoryGirl.create(:student, course: course) 
    task               = course.tasks.first
    @course_membership = course.membership_for(student)
    @student_task      = StudentTask.new(@course_membership, task) 
  end

  describe "when the task is not completed" do

    it "should have an incomplete status" do
      @student_task.complete?.must_equal false 
    end

  end

  describe "when the task is completed" do 

    before do
      @student_task.complete("Puzzlenode")
    end

    it "should be complete" do
      @student_task.complete?.must_equal true
    end

    it "should have a completed status" do
      @student_task.status.must_equal "Puzzlenode" 
    end

    describe "when it is updated after completing" do

      before do
        @student_task.complete("Community")
      end

      it "should not create another completed task" do
        @course_membership.completed_tasks.count.must_equal 1
      end

      it "should have the updated status" do
        @student_task.status.must_equal "Community" 
      end

    end

  end
end
