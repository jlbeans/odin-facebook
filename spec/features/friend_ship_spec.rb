require 'rails_helper'

feature 'accept or decline friend requests' do
  given(:user1) { FactoryBot.create(:user) }
  given(:user2) { FactoryBot.create(:user) }

  background(:each) { sign_in user2 }

  scenario 'accepting a friend request creates a new friendship' do
    FriendRequest.create(sender: user1, receiver: user2)
    visit friend_requests_url
    find('.is-primary').click
    visit friend_ships_url
    within("div.friends-container") do
      expect(page).to have_content(user1.name)
    end
  end

  scenario 'accepting a friend request deletes the request' do
    FriendRequest.create(sender: user1, receiver: user2)
    visit friend_requests_url
    find('.is-primary').click
    within("div.current-requests") do
      expect(page).not_to have_content(user1.name)
    end
  end

  scenario 'declining a friend request does not add friend' do
    FriendRequest.create(sender: user1, receiver: user2)
    visit friend_requests_url
    find('.is-danger').click
    visit friend_ships_url
    within("div.friends-container") do
      expect(page).not_to have_content(user1.name)
    end
  end

  scenario 'declining a friend request deletes the request' do
    FriendRequest.create(sender: user1, receiver: user2)
    visit friend_requests_url
    find('.is-danger', visible: false).click
    within("div.current-requests") do
      expect(page).not_to have_content(user1.name)
    end
  end
end
