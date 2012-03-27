class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    matches      = Discussion.search(params)
    @discussions = DiscussionListDecorator.new(matches)
  end

  def new
    raise NotImplementedError
  end
  
  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
end
