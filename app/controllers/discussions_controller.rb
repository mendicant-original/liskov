class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    matches      = Discussion.search(params)
    @discussions = DiscussionListDecorator.new(matches)
  end

  def new
    @discussion = Discussion.new
    @category   = params[:category]
  end
  
  def create
    discussion_params = params[:discussion].
                        merge(:author => current_person.github_nickname)
                        
    discussion = Discussion.create(discussion_params)
    redirect_to course_discussion_path(params[:course_id], discussion)
  end
  
  def show
    raise NotImplementedError
  end
  
  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
end
