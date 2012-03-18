class PersonDecorator
  extend Forwardable

  def_delegators :@person, :name, :email, :github_nickname, :permissions

  def initialize(person)
    @person = person
  end

  def has_role?(role, course)
    membership = course.course_memberships.for_person(@person).first
    membership.has_role?(role) if membership
  end
end
