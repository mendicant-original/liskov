FactoryGirl.define do
  factory :webdev, class: Course do
    name "Web Development"
    description "MU's Web Development Course"
    after_create do |c|
      Factory(:community_service, :course => c)
      Factory(:personal_project , :course => c)
      Factory(:challenge        , :course => c)
    end
  end
end
