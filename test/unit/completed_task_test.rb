require "test_helper"
require "minitest/spec"

describe CompletedTask do

  before do
    @course      = FactoryGirl.create(:webdev)
    @student     = FactoryGirl.create(:student, course: @course) 
    @task        = @course.tasks.first
    @participant = @course.membership_for(@student)
  end

  describe "when the task is not completed" do
    it "should have an incomplete status" do
      @participant.status_for(@task).must_equal CompletedTask::NOT_COMPLETE
    end
  end

  describe "when the task is completed" do 
    before do
      @participant.complete_task(@task, "Puzzlenode")
    end

    it "should have a completed status" do
      @participant.status_for(@task).must_equal "Puzzlenode" 
    end

    describe "when it is updated after completing" do
      before do
        @participant.complete_task(@task, "Community")
      end

      it "should not create another completed task" do
        @participant.completed_tasks.count.must_equal 1
      end

      it "should have the updated status" do
        @participant.status_for(@task).must_equal "Community" 
      end
    end

  end
end
