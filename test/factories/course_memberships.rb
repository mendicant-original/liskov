FactoryGirl.define do
  factory :instructor, class: CourseMembership do
    association :course, factory: 'webdev'
    person_github_nickname 'instructor'
    role 'Instructor'
  end
end

