class DiscussionsController < ApplicationController
  before_filter :find_course
  before_filter :find_discussion, :except => [:new, :create, :index]

  def index
    matches      = @course.discussions.search(params)
    @discussions = DiscussionListDecorator.new(matches)
  end

  def new
    @discussion = Discussion.new
    # TODO: unify this with decorator logic
    @category   = params[:category] || "conversations" 
  end
  
  def update
    @discussion.update_attributes(params[:discussion])
    redirect_to course_discussion_path(@course.id, @discussion)
  end
  
  def show
    @discussion = DiscussionDecorator.decorate(@discussion)
  end
  
  def create
    discussion_params = params[:discussion].
                        merge(:author    => current_person.github_nickname,
                              :course_id => @course.id)
                        
    discussion = Discussion.create(discussion_params)
    redirect_to course_discussion_path(@course.id, discussion)
  end
  
  # TODO: Seperate this into an admin feature which really destroys,
  # and an archive route. Also, provide a way to re-open the discussions.
  def destroy
    @discussion.update_attribute(:archived, true)
    
    redirect_to course_discussions_path
  end
  
  private
  
  def find_course
    @course = Course.find(params[:course_id])
  end
  
  def find_discussion
    @discussion = Discussion.find(params[:id])
  end
end
