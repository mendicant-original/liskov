class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :user_required

  helper_method :current_user, :signed_in?, :login_path

  def current_user
    begin
      @current_user ||= Clubhouse::Client::Person.new(session[:person_github_nickname])
    rescue Clubhouse::Client::PersonNotFound

    end
    @current_user
  end

  def signed_in?
    !!current_user
  end

  def current_user=(person)
    @current_user = person
    session[:person_github_nickname] = person.try(:github_nickname)
  end

  def user_required
    unless signed_in?
      redirect_to login_path
      return true
    end
  end

  def login_path
    Rails.env.development? ? '/auth/developer' : '/auth/github'
  end
end
