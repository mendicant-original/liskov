require_relative '../test_helper'
require 'minitest/spec'
 
describe Course do

  before do
    @course = Course.create
  end

  describe "adding tasks" do

    it "can have tasks with a valid description" do
      @course.add_task("new task")
      @course.tasks.length.must_equal 1
    end

    it "can't have tasks with no description" do
      @course.add_task(nil)
      @course.tasks[0].errors.any?.must_equal true
    end

  end
end
