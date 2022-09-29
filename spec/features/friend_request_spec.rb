require 'rails_helper'

feature 'incoming friend requests page' do
  given(:user) { FactoryBot.create(:user) }

  background(:each) { sign_in user }

  scenario 'shows a user\'s friend requests' do
    2.times { FriendRequest.create(receiver: user, sender: FactoryBot.create(:user)) }
    visit friend_requests_url
    User.last(2).pluck(:name).each do |name|
      expect(page).to have_content(name)
    end
  end

  feature 'new friend request' do
    given(:user1) { FactoryBot.create(:user) }
    given(:user2) { FactoryBot.create(:user) }

    background(:each) { sign_in user1 }

    scenario 'shows that friend request was sent' do
      visit users_url
      find('.is-primary').click
      expect(page).to have_content('Friend request sent!')
    end

    scenario 'shows that sent request has been canceled' do
      visit users_url
      find('.is-primary').click
      find('.is-danger').click
      expect(page).to have_content('Friend request canceled!')
      end
    end
  end 
