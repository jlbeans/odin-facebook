require 'rails_helper'

RSpec.describe FriendRequest, type: :model do
  subject(:friend_request) { FactoryBot.build(:friend_request) }

  describe 'validations' do
    it { should validate_uniqueness_of(:receiver_id).scoped_to(:sender_id) }

    context 'custom validations' do
      let(:user1) { FactoryBot.create(:user) }
      let(:user2) { FactoryBot.create(:user) }


      describe '#not_self' do
        it 'should not allow user to send request to self' do
          request = FriendRequest.new(sender: user1, receiver: user1)
          expect(request.valid?).to be false
        end
      end

      describe '#no_pending_request' do
        it 'should not allow a duplicate request' do
          FriendRequest.create(sender: user1, receiver: user2)
          request = FriendRequest.new(sender: user2, receiver: user1)
          expect(request.valid?).to be false
        end
      end
    end

  describe 'active record associations' do
    it { should belong_to(:receiver) }
    it { should belong_to(:sender) }
  end
 end
end
