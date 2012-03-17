class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    if params[:state] == "closed"
      @discussions = case params[:category]
      when "conversation"
        @course.discussions.inactive.conversations
      when "review"
        @course.discussions.inactive.reviews
      when "evaluation"
        @course.discussions.inactive.evaluations
      else
        @course.discussions.inactive.conversations
      end
    else
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
  end

  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
end
