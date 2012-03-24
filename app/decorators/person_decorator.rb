class PersonDecorator < ApplicationDecorator
  decorates :person, :class => Clubhouse::Client::Person

  allows :name, :email, :github_nickname, :permissions

  def self.from_github(github_nickname)
      PersonDecorator.new(Clubhouse::Client::Person.new(github_nickname))
    rescue Clubhouse::Client::PersonNotFound
      return nil
  end

  def membership_for(course)
    course.membership_for(person)
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
