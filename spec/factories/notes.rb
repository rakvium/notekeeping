FactoryGirl.define do
  factory :note do
    text { Faker::Lorem.paragraph }
    user
  end
end
