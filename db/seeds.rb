course = Course.find_or_create_by_name(
  name: "Web Development",
  description: "# Welcome to Web Dev 3.0!"
)

frank   = course.course_memberships.where(person_github_nickname: "frank_pepelio")
barbora = course.course_memberships.where(person_github_nickname: "barbora_kelmer")

people = [frank, barbora]

people.each do |person|
  person.create(course_id: course.id, role: "Student") if person.empty?
end