require 'rails_helper'

feature 'user show page' do
  given(:user) { FactoryBot.create(:user, location: 'City') }
  given(:post) { FactoryBot.create(:post, user: user) }

  background(:each) { sign_in user }

  scenario 'shows a user\'s info' do
    visit user_url(user)
    expect(page).to have_content(user.name)
    expect(page).to have_content('City')
  end

  scenario 'shows a user\'s posts' do
    post
    visit user_url(user)
    expect(page).to have_content(post.body)
  end
end

feature 'edit profile information' do
  given(:user) { FactoryBot.create(:user) }

  background(:each) { sign_in user }

  scenario 'renders edit profile page' do
    visit edit_user_url(user)
    expect(page).to have_content('Update Profile')
  end

  scenario 'changes user location' do
    visit edit_user_url(user)
    fill_in 'user[location]', with: 'New City'
    click_on 'Update'
    expect(page).to have_content('New City')
  end
end
