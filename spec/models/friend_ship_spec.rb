require 'rails_helper'

RSpec.describe FriendShip, type: :model do
  let(:user) { User.create!(first_name: 'user', last_name: 'test', email: 'user@test.com', password: 'password', password_confirmation: 'password') }
  let(:friend) { User.create(first_name: 'friend', last_name: 'test', email: 'friend@test.com', password: 'password', password_confirmation: 'password') }

  context 'friendship already exists' do
    it 'does not create new friendship' do
      user.friend_ships.create(friend: friend)
      friendship = user.friend_ships.new(friend: friend)
      expect(friendship).to be_invalid
    end
  end

  context 'friendship does not exist' do
    context 'user is same as friend' do
      it 'does not create new friendship' do
        friendship = user.friend_ships.new(friend: user)
        expect(friendship).to be_invalid
      end
    end

    context 'user and friend are different' do
      it 'creates new friendship' do
        friendship = user.friend_ships.new(friend: friend)
        expect(friendship).to be_valid
      end
    end
  end
end
