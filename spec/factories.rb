FactoryGirl.define do
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
