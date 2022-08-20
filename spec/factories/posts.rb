FactoryBot.define do
  factory :post do
    body { Faker::Quotes::Shakespeare }
    user { create(:user) }
  end
end
