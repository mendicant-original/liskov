class StudentsController < ApplicationController

  before_filter :find_course, :find_person, :find_membership

  def show
    @student = StudentDecorator.new(@membership)
  end

  private

  def find_person
    @person = clubhouse_person(params[:id])

    unless @person
      redirect_to(@course, alert: "Student does not exist.")
    end
  end

  def find_membership
    @membership = @course.membership_for(@person)

    unless @membership
      redirect_to(@course, alert: "Student does not belong to course.")
    end
  end
end
