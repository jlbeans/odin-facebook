require 'rails_helper'

RSpec.describe "/friend_requests", type: :request do
  let(:sample_friend_request) { FactoryBot.create(:friend_request) }

  describe 'POST /create' do
    it 'creates a new Friend Request' do
      sender = FactoryBot.create(:user)
      receiver = FactoryBot.create(:user)
      sign_in sender
      expect {
        post friend_requests_url, params: { receiver_id: receiver.id }
      }.to change(FriendRequest, :count).by(1)
    end
  end

  describe 'POST /accept' do
    before(:each) { sign_in sample_friend_request.receiver }

    it 'creates a new Friendship' do
      expect {
        post accept_friend_request_url(sample_friend_request), params: { id: sample_friend_request.to_param }
      }.to change(FriendShip, :count).by(1)
      expect(FriendShip.last.user).to eq(sample_friend_request.receiver)
      expect(FriendShip.last.friend).to eq(sample_friend_request.sender)
    end

    it 'destroys the accepted request' do
      expect {
        post accept_friend_request_url(sample_friend_request), params: { id: sample_friend_request.to_param }
      }.to change(FriendRequest, :count).by(-1)
    end
  end

  describe 'DELETE /decline' do
    it 'destroys the request through receiver' do
      sign_in sample_friend_request.receiver
      expect {
        delete decline_friend_request_url(sample_friend_request), params: { id: sample_friend_request.to_param }
      }.to change(FriendRequest, :count).by(-1)
      end
    end

    describe 'DELETE /cancel' do
      it 'destroys the request through sender' do
        sign_in sample_friend_request.sender
        expect {
          delete cancel_friend_request_url(sample_friend_request), params: { id: sample_friend_request.to_param }
        }.to change(FriendRequest, :count).by(-1)
        end
      end
    end
