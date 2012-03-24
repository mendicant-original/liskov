FactoryGirl.define do
  factory :person, class: OpenStruct do
    name            "Test"
    email           "test@gmail.com"
    email_hash      "6d2661c5a65f24c8f0bb579b6e0a0d81"
    group           "Visitor"
    website         nil
    membership_date nil
    github_uid      "1234"
    github_nickname "github_nickname"
    permissions     Hash[[["Clubhouse", "Administrator"],
                          ["Community", "Administrator"],
                          ["Liskov",    "Administrator"]]]
  end

  factory :instructor, parent: "person" do
    name            "Instructor"
    github_nickname "instructor"

    after_build do |instructor, this_factory|
      FactoryGirl.create(:instructor_membership, course: instructor.course) if instructor.course
    end
  end

  factory :student, parent: "person" do
    name            "Student"
    github_nickname "student"

    after_build do |student, this_factory|
      FactoryGirl.create(:student_membership, course: student.course) if student.course
    end
  end
end
