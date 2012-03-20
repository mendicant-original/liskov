class PersonDecorator < ApplicationDecorator
  decorates :person, :class => Clubhouse::Client::Person

  allows :name, :email, :github_nickname, :permissions

  def has_role?(role, course)
    membership = course.course_memberships.for_person(person).first
    membership.has_role?(role) if membership
  end
end
