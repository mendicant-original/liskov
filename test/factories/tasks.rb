FactoryGirl.define do
  factory :community_service, class: Task do
    description "Community Service"
  end
  factory :personal_project, class: Task do
    description "Personal Project"
  end
  factory :challenge, class: Task do
    description "Challenge"
  end
end
