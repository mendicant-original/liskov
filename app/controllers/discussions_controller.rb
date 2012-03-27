class DiscussionsController < ApplicationController
  before_filter :find_course

  def index
    matches      = @course.discussions.search(params)
    @discussions = DiscussionListDecorator.new(matches)
  end

  def new
    @discussion = Discussion.new
    @category   = params[:category]
  end
  
  def edit
    raise NotImplementedError
  end
  
  def create
    discussion_params = params[:discussion].
                        merge(:author    => current_person.github_nickname,
                              :course_id => @course.id)
                        
    discussion = Discussion.create(discussion_params)
    redirect_to course_discussion_path(params[:course_id], discussion)
  end
  
  def show
    @discussion = DiscussionDecorator.find(params[:id])
  end
  
  # TODO: Seperate this into an admin feature which really destroys,
  # and an archive route. Also, provide a way to re-open the discussions.
  def destroy
    Discussion.find(params[:id]).update_attribute(:archived, true)
    
    redirect_to course_discussions_path
  end
  
  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
end
