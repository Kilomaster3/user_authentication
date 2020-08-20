FactoryBot.define do
  factory :user do
    name { 'Alex' }
    surname { 'Hrom' }
    sequence(:email) { |n| "test-#{n}@example.com" }
    password { 'aF234567%' }
  end
end