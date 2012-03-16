class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    @discussions = case params[:category]
    when "conversation"
      @course.discussions.conversations
    when "review"
      @course.discussions.reviews
    when "evaluation"
      @course.discussions.evaluations
    else
      @course.discussions.conversations
    end
  end

  def find_course
    @course = Course.find(params[:course_id])
  end
end
