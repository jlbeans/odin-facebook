require 'rails_helper'

RSpec.describe "/friend_requests", type: :request do
  describe 'POST /create' do
    it 'creates a new FriendRequest' do
      sender = FactoryBot.create(:user)
      receiver = FactoryBot.create(:user)
      sign_in sender
      expect {
        post friend_requests_url, params: { friend_request: { sender_id: sender.id, receiver_id: receiver.id} }
      }.to change(FriendRequest, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the request' do
      request = FactoryBot.create(:friend_request)
      sender = request.sender
      sign_in sender
      expect {
        delete friend_request_url(request)
      }.to change(FriendRequest, :count).by(-1)
      end
    end
  end
