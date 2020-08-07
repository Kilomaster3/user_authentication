FactoryBot.define do
  factory :user do
    name { 'Alex' }
    surname { 'Hrom' }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { '12334567' }
  end
end