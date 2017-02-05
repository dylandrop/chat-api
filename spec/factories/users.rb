FactoryGirl.define do
  sequence(:email) { |n| "test#{n}@mysite.com" }

  factory :user do
    name 'Walter White'
    email
    password 'ilovechat'
  end
end
