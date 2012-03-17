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

conversations = [ "How awesome is Jordan Byron?",
                  "How many unicorns does it take to make a rainbow?",
                  "Can someone ask a serious question please?" ]

conversations.each do |e|
  course.discussions.find_or_create_by_subject(
    :subject => e, :category => "conversation"
  )
end

evaluations =  [ "My s10-e2 is ready for evaluation",
                 "Revisions have been made to my s10-e1",
                 "Come on, evaluate it, you know you want to!" ]

evaluations.each do |e|
  course.discussions.find_or_create_by_subject(
    :subject => e, :category => "evaluation"
  )
end

reviews = ["Messy first spike on my individual project",
          "Proof of concept patch to add archives to Newman",
          "If you don't review this soon, I might go crazy!"]

reviews.each do |e|
  course.discussions.find_or_create_by_subject(
    :subject => e, :category => "review"
  )
end