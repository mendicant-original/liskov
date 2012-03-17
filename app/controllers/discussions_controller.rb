class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    @discussions = case params[:category]
    when "conversation"
      @course.discussions.active.conversations
    when "review"
      @course.discussions.active.reviews
    when "evaluation"
      @course.discussions.active.evaluations
    else
      @course.discussions.active.conversations
    end
  end

  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
end
