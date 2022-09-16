FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Internet.password(min_length: 6) }
    profession { Faker::Job.title }
    location { Faker::Nation.capital_city}
  end
end
