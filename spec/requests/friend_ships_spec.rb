require 'rails_helper'

RSpec.describe "/friend_ships", type: :request do
  let(:friend_request) { FactoryBot.create(:friend_request) }

  describe 'POST /create' do
    it 'creates a new FriendShip' do
    receiver = friend_request.receiver
    sign_in receiver
      expect {
        post friend_ships_url, params: { friend_ship: { friend: request.sender, user: request.receiver } }
      }.to change(FriendShip, :count).by(1)
    end
  end

  describe 'DELETE /destroy' do
    let(:friend_ship) { FactoryBot.create(:friend_ship) }
      before(:each) { sign_in friend_ship.user }

      it 'destroys the friendship' do
        expect {
          delete friend_ship_url(friend_ship)
        }.to change(FriendShip, :count).by(-1)
      end
    end
  end
