
require 'rails_helper'

RSpec.describe FriendShip, type: :model do
  subject(:friend_ship) { FactoryBot.build(:friend_ship) }

  describe 'active record associations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end

  describe 'validations' do
    it { should validate_uniqueness_of(:user_id).scoped_to(:friend_id) }

    context 'custom validations' do
      let(:user1) { FactoryBot.create(:user) }
      let(:user2) { FactoryBot.create(:user) }

      describe '#not_self' do
        it 'should not allow a user to be friends with themselves' do
          friendship = FriendShip.new(user: user1, friend: user1)
          expect(friendship.valid?).to be false
        end
      end

      describe '#not_duplicate' do
        it 'should not allow a duplicated friendship' do
          FriendShip.create!(user: user1, friend: user2)
          friendship = FriendShip.new(user: user2, friend: user1)
          expect(friendship.valid?).to be false
        end
      end
    end
  end
end
