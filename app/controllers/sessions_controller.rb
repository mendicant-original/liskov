class SessionsController < ApplicationController
  skip_before_filter :person_required

  def create
    person = clubhouse_person(auth_hash['info']['nickname'])

    if person && person.can_access_liskov?
      self.current_person = person
    else
      flash[:error] = "Sorry, but you need a Clubhouse ID and access to Liskov."
    end

    redirect_to request.env['omniauth.origin'] || root_path
  end

  def destroy
    self.current_person = nil

    redirect_to request.env['HTTP_REFERER'] || root_path
  end

  def failure
    flash[:error] = "There was a problem logging in. Please try again"

    self.current_person = nil # Try destroying the current_user

    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
