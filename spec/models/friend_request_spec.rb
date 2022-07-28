require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  let(:user1) { User.new(id: 1,
    first_name: 'Person',
    last_name: 'One',
    email: 'rspec1@test.com',
    password: 'password',
    password_confirmation: 'password') }

  let(:user2) { User.new(id: 2,
    first_name: 'Person',
    last_name: 'Two',
    email: 'rspec2@test.com',
    password: 'password',
    password_confirmation: 'password') }

  let!(:first_request) { FriendRequest.create(sender: user1, receiver: user2) }


  context 'friend_request does not exist' do
    it 'should be valid' do
      second_request = FriendRequest.new(sender: user2, receiver: user1)
      expect(second_request).to be_valid
    end
  end
end
