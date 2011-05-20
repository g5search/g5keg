FactoryGirl.define do
  factory :beer do
    name 'Green Lakes IPA'
    description 'This is a great hoppy beer.'
    association :brewery
  end
end
