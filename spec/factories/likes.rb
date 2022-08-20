FactoryBot.define do
  factory :like do
    user { create(:user) }
    likable { create(:post) }
  end
end
