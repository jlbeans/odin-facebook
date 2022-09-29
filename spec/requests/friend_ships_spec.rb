require 'rails_helper'

RSpec.describe "/friend_ships", type: :request do
    describe 'DELETE /destroy' do
      let(:friend_ship) { FactoryBot.create(:friend_ship) }
      before(:each) { sign_in friend_ship.friend }

      it 'destroys the selected friendship' do
        expect {
          delete friend_ship_url(friend_ship), params: {
            user: friend_ship.user,
            friend: friend_ship.friend
          }
        }.to change(FriendShip, :count).by(-1)
      end
    end
  end
