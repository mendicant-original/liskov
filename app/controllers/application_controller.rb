class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :person_required

  helper_method :current_person

  def current_person
    @current_person ||= clubhouse_person(session[:person_github_nickname])
  end

  def signed_in?
    !!current_person
  end

  def current_person=(person)
    @current_person = person
    session[:person_github_nickname] = person.try(:github_nickname)
  end

  def person_required
    unless signed_in?
      redirect_to login_path
      return true
    end
  end

  def login_path
    Rails.env.production? ? '/auth/github' : '/auth/developer'
  end

  private

  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  def find_course
    course_id = params[:course_id] || params[:id]
    @course = Course.find(course_id)
  rescue ActiveRecord::RecordNotFound
    not_found
  end

  def find_student
    @course ||= find_course
    person = clubhouse_person(params[:student_id] || params[:id])
    membership = @course.membership_for(person) || not_found
    @student = StudentDecorator.new(membership)
  end

  def clubhouse_person(github_nickname)
    PersonDecorator.from_github(github_nickname)
  end
end
