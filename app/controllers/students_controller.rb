class StudentsController < ApplicationController

  before_filter :find_course, :find_person, :find_membership

  def show
    puts @membership
  end

  private

  #TODO: This is duped in TasksController. DRY it up!
  def find_course
    @course = Course.find(params[:course_id])
  rescue ActiveRecord::RecordNotFound
    redirect_to(root_url, alert: "Couldn't find course")
  end

  def find_person
    @person = clubhouse_person(params[:id])

    unless @person 
      redirect_to(course_url(@course), alert: "Student does not exist.") 
    end
  end

  def find_membership
    @membership = @course.membership_for(@person)

    unless @membership
      redirect_to(course_url(@course), alert: "Student does not belong to course.") 
    end
  end
end
