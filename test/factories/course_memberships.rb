FactoryGirl.define do
  factory :student_membership, class: CourseMembership do
    course                  nil
    person_github_nickname  "student"
    role                    "Student"
  end

  factory :instructor_membership, class: CourseMembership do
    course                  nil
    person_github_nickname  "instructor"
    role                    "Instructor"
  end
end
