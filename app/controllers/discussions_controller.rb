class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    @discussions = case params[:category]
    when "conversation"
      Discussion.conversations
    when "review"
      Discussion.reviews
    when "evaluation"
      Discussion.evaluations
    else
      Discussion.conversations
    end
  end

  def find_course
    @course = Course.find(params[:course_id])
  end
end
