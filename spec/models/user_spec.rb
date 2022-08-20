require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { FactoryBot.build(:user) }

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
  end

  describe 'active record associations' do
    context 'model relationships' do
      it { should have_many(:posts) }
      it { should have_many(:likes) }
      it { should have_many(:comments) }
      it { should have_many(:sent_friend_requests) }
      it { should have_many(:received_friend_requests) }
      it { should have_one_attached(:avatar) }
    end

    context 'user friendships' do
      let(:user1) { FactoryBot.create(:user) }
      let(:user2) { FactoryBot.create(:user) }


      it 'should have multiple friendships' do
        friendship1 = FriendShip.create!(user: user, friend: user1)
        friendship2 = FriendShip.create!(user: user, friend: user2)
        expect(user.friend_ships).to eq([friendship1, friendship2])
      end

      describe '#friends' do
        it 'should have friends through friendships' do
          FriendShip.create!(user: user, friend: user1)
          FriendShip.create!(friend: user2, user: user)
          expect(user.friends).to eq([user1, user2])
        end
      end
    end
  end
end
