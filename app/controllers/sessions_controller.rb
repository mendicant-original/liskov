class SessionsController < ApplicationController

  def test
    person = Clubhouse::Client::Person.new("jordanbyron")

    render :text => "Nice job #{person.name}!"
  end

end
