class CourseMembershipsController < ApplicationController
  def create
    course_membership = CourseMembership.new(params[:course_membership])

    course_membership.save!

    redirect_to course_path(course_membership.course)
  end

  def destroy
    course_membership = CourseMembership.find(params[:id])

    course_membership.destroy

    redirect_to course_path(course_membership.course)
  end
end
