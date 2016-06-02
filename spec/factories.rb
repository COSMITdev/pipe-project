FactoryGirl.define do
  factory :project_user do
    project nil
    user nil
  end
  factory :invitation do
    project nil
    email "MyString"
  end
  factory :comment do
    user nil
    topic ""
    body "MyText"
  end
  factory :topic do
    user nil
    project nil
    title "MyString"
    body "MyText"
  end
  factory :project do
    user_id nil
    name "MyString"
  end
  factory :user do

  end

  factory :admin_user do

  end
end
