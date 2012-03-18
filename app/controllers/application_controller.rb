class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :person_required

  helper_method :current_person, :signed_in?, :login_path

  def current_person
    begin
      @current_person ||= clubhouse_person(session[:person_github_nickname])
    rescue Clubhouse::Client::PersonNotFound

    end
    @current_person
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

  def clubhouse_person(github_nickname)
    PersonDecorator.new(Clubhouse::Client::Person.new(github_nickname))
  end

end
