FactoryBot.define do
  factory :friend_ship do
    user { create(:user)}
    friend { create(:user) }
  end
end
