class SessionsController < ApplicationController
  skip_before_filter :person_required

  def create
    begin
      person = Clubhouse::Client::Person.new(auth_hash['info']['nickname'])
    rescue Clubhouse::Client::PersonNotFound
      flash[:error] = "Sorry, but we couldn't find your record in Clubhouse"
    end

    # TODO check person's permissions for Liskov

    self.current_person = person

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
