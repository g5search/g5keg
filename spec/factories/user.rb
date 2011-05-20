FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "bob.#{n}@dobolina.com" }
    sequence(:identity) { |n| "identity-#{n}" }
  end
end
