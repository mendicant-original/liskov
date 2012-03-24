class PersonDecorator < ApplicationDecorator
  decorates :person, :class => Clubhouse::Client::Person

  allows :name, :email, :github_nickname, :permissions

  def membership_for(course)
    course.course_memberships.for_person(person).first
  end

  def role_for(course)
    membership_for(course).try(:role)
  end

  def has_role?(role, course)
    membership = membership_for(course)
    membership.has_role?(role) if membership
  end

  def to_param
    github_nickname
  end

  def ==(person)
    github_nickname == person.github_nickname
  end
end
