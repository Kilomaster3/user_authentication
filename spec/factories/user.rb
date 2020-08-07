FactoryBot.define do
  factory :user, class: User do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    password { Faker::Internet.password(min_length: 10, max_length: 16, mix_case: true) }
    email { Faker::Internet.email }
  end
end