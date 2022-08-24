require 'rails_helper'

RSpec.describe FriendRequestsController, type: :controller do
  let(:friend_request) { FactoryBot.create(:friend_request) }

  describe 'POST #create' do
    it 'creates a new FriendRequest' do
      sender = FactoryBot.create(:user)
      receiver = FactoryBot.create(:user)
      sign_in sender
      expect {
        post :create, params: { sender_id: sender.id, receiver_id: receiver.id }
      }.to change(FriendRequest, :count).by(1)
      expect(FriendRequest.last.sender).to eq(sender)
      expect(FriendRequest.last.receiver).to eq(receiver)
    end
  end


  describe 'DELETE #destroy' do
    it 'destroys the request' do
      expect {
        delete :destroy, params: { id: friend_request.id }
      }.to change(FriendRequest, :count).by(-1)
      end
    end
  end
