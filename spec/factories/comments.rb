FactoryBot.define do
  factory :comment do
    body { Faker::Lorem.sentence }
    user { create(:user) }
    commentable { create(:post) }
  end
end
