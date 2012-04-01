FactoryGirl.define do
  factory :student_membership, class: CourseMembership do
    course                  nil
    person_github_nickname  "student"
    role                    "Student"

    after_create do |ms, this_factory|
      ms.create_study_plan(content: "## Study Plan")
    end
  end

  factory :instructor_membership, class: CourseMembership do
    course                  nil
    person_github_nickname  "instructor"
    role                    "Instructor"
  end
end
