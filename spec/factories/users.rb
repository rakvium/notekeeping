FactoryGirl.define do
  factory :user do
    email { Faker::Internet.safe_email }
    password { Faker::Lorem.characters(8) }
  end
end
