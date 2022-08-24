require 'rails_helper'

RSpec.describe FriendShipsController, type: :controller do


  describe 'POST #create' do
    let(:friend_request) { FactoryBot.create(:friend_request) }

    it 'creates a new Friendship' do
      expect {
        post :create, params: { user: friend_request.receiver, friend: friend_request.sender }
      }.to change(FriendShip, :count).by(1)
    end

      it 'destroys the request' do
        expect {
          post :create, params: { id: friend_request.id}
        }.to change(FriendRequest, :count).by(-1)
      end
     end

  describe 'DELETE #destroy' do
    let(:friend_ship) { FactoryBot.create(:friend_ship) }

      it 'destroys the requested friendship' do
        expect {
          delete :destroy, params: {
                             id: friend_ship.id
                           }
        }.to change(FriendShip, :count).by(-1)
      end
    end
  end
